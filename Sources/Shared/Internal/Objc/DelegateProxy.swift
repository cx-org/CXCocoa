import Foundation

class DelegateProxy<Delegate: NSObjectProtocol>: NSObject {
    weak var forwardee: Delegate? {
        didSet {
            originalSetter(self)
        }
    }

    var interceptedSelectors: Set<Selector> = []

    private let lifetime: Lifetime
    private let originalSetter: (AnyObject) -> Void

    required init(lifetime: Lifetime, _ originalSetter: @escaping (AnyObject) -> Void) {
        self.lifetime = lifetime
        self.originalSetter = originalSetter
    }

    override func forwardingTarget(for selector: Selector!) -> Any? {
        return interceptedSelectors.contains(selector) ? nil : forwardee
    }

    func intercept(_ selector: Selector) -> AnyPublisher<(), Never> {
        interceptedSelectors.insert(selector)
        originalSetter(self)
        return self.cx.methodInvoked(for: selector).take(while: self.lifetime).eraseToAnyPublisher()
    }

    func intercept(_ selector: Selector) -> AnyPublisher<[Any?], Never> {
        interceptedSelectors.insert(selector)
        originalSetter(self)
        return self.cx.publish(selector).take(while: self.lifetime).eraseToAnyPublisher()
    }

    override func responds(to selector: Selector!) -> Bool {
        if interceptedSelectors.contains(selector) {
            return true
        }

        return (forwardee?.responds(to: selector) ?? false) || super.responds(to: selector)
    }
}

private extension AssociateKeys {
    static let isSwizzled = AssociateKey<Bool>()
}

extension DelegateProxy {
    // FIXME: This is a workaround to a compiler issue, where any use of `Self`
    //        through a protocol would result in the following error messages:
    //        1. PHI node operands are not the same type as the result!
    //        2. LLVM ERROR: Broken function found, compilation aborted!
    static func proxy<P: DelegateProxy<Delegate>>(
        for instance: NSObject,
        setter: Selector,
        getter: Selector
    ) -> P {
        return _proxy(for: instance, setter: setter, getter: getter) as! P
    }

    private static func _proxy(
        for instance: NSObject,
        setter: Selector,
        getter: Selector
    ) -> AnyObject {
        return Global.sync(instance) {
            let key = AssociateKey<AnyObject>(setter.delegateProxyAlias)

            if let proxy = instance.cx.getAssociated(for: key) {
                return proxy
            }

            let superclass: AnyClass = class_getSuperclass(swizzleClass(instance))!

            let invokeSuperSetter: @convention(c) (NSObject, AnyClass, Selector, AnyObject?) -> Void = { object, superclass, selector, delegate in
                typealias Setter = @convention(c) (NSObject, Selector, AnyObject?) -> Void
                let impl = class_getMethodImplementation(superclass, selector)
                unsafeBitCast(impl, to: Setter.self)(object, selector, delegate)
            }

            let newSetterImpl: @convention(block) (NSObject, AnyObject?) -> Void = { object, delegate in
                if let proxy = object.cx.getAssociated(for: key) as! DelegateProxy<Delegate>? {
                    proxy.forwardee = (delegate as! Delegate?)
                } else {
                    invokeSuperSetter(object, superclass, setter, delegate)
                }
            }

            // Hide the original setter, and redirect subsequent delegate assignment
            // to the proxy.
            instance.swizzle((setter, newSetterImpl), key: AssociateKeys.isSwizzled)

            // As Objective-C classes may cache the information of their delegate at
            // the time the delegates are set, the information has to be "flushed"
            // whenever the proxy forwardee is replaced or a selector is intercepted.
            let proxy = self.init(lifetime: Lifetime.of(instance)) { [weak instance] proxy in
                guard let instance = instance else { return }
                invokeSuperSetter(instance, superclass, setter, proxy)
            }

            typealias Getter = @convention(c) (NSObject, Selector) -> AnyObject?
            let getterImpl: IMP = class_getMethodImplementation(object_getClass(instance), getter)!
            let original = unsafeBitCast(getterImpl, to: Getter.self)(instance, getter) as! Delegate?

            // `proxy.forwardee` would invoke the original setter regardless of
            // `original` being `nil` or not.
            proxy.forwardee = original

            // The proxy must be associated after it is set as the target, since
            // `base` may be an isa-swizzled instance that is using the injected
            // setters above.
            instance.cx.setAssociated(proxy, for: key)

            return proxy
        }
    }
}
