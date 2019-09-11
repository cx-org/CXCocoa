import Foundation

private extension AssociateKeys {
    
    static let isSwizzled = AssociateKey<Bool>()
    static let lifetimeTracer = AssociateKey<Lifetime.Tracer>()
}

private extension Lifetime {
    
    class Tracer {
        let lifetime = Lifetime()
        init() { }
        deinit {
            self.lifetime._isEnded.set(true)
            self.lifetime.subject.send(completion: .finished)
        }
    }
}

final class Lifetime: Publisher {
    
    private let _isEnded = Atom(val: false)
    private let subject = PassthroughSubject<Void, Never>()
    
    var isEnded: Bool {
        return self._isEnded.get()
    }
    
    private init() { }
    
    private static func makeTracer() -> (Lifetime, Tracer) {
        let tracer = Tracer()
        return (tracer.lifetime, tracer)
    }
    
    static func of(_ object: AnyObject) -> Lifetime {
        if let object = object as? NSObject {
            return self.of(object)
        }
        
        return Global.sync(object) {
            let box = AnyCXWrapper(object)
            if let tracer = box.getAssociated(for: AssociateKeys.lifetimeTracer) {
                return tracer.lifetime
            }
            
            let tracer = Tracer()
            box.setAssociated(tracer, for: AssociateKeys.lifetimeTracer)
            return tracer.lifetime
        }
    }
    
    static func of(_ object: NSObject) -> Lifetime {
        return Global.sync(object) {
            if let tracer = object.cx.getAssociated(for: AssociateKeys.lifetimeTracer) {
                return tracer.lifetime
            }
            
            let tracer = Tracer()
            let objcClass: AnyClass = (object as AnyObject).objcClass
            let objcClassBox = AnyCXWrapper(objcClass as AnyObject)
            
            let deallocSelector = sel_registerName("dealloc")
            
            // Swizzle `-dealloc` so that the lifetime token is released at the
            // beginning of the deallocation chain, and only after the KVO `-dealloc`.
            Global.sync(objcClass) {
                // Swizzle the class only if it has not been swizzled before.
                if objcClassBox.getAssociated(for: AssociateKeys.isSwizzled) == nil {
                    objcClassBox.setAssociated(true, for: AssociateKeys.isSwizzled)
                    
                    var existingImp: IMP?
                    let newImpBlock: @convention(block) (UnsafeRawPointer) -> Void = { objectRef in
                        // A custom trampoline of `objc_setAssociatedObject` is used, since
                        // the imported version has been inserted with ARC calls that would
                        // mess with the object deallocation chain.
                        
                        // Release the lifetime token.
                        unsafeSetAssociatedValue(nil, forKey: AssociateKeys.lifetimeTracer, forObjectAt: objectRef)
                        
                        let imp: IMP
                        
                        // Call the existing implementation if one has been caught. Otherwise,
                        // call the one first available in the superclass hierarchy.
                        if let existingImp = existingImp {
                            imp = existingImp
                        } else {
                            let superclass: AnyClass = class_getSuperclass(objcClass)!
                            imp = class_getMethodImplementation(superclass, deallocSelector)!
                        }
                        
                        typealias Imp = @convention(c) (UnsafeRawPointer, Selector) -> Void
                        unsafeBitCast(imp, to: Imp.self)(objectRef, deallocSelector)
                    }
                    
                    let newImp = imp_implementationWithBlock(newImpBlock as Any)
                    
                    if !class_addMethod(objcClass, deallocSelector, newImp, "v@:") {
                        // The class has an existing `dealloc`. Preserve that as `existingImpl`.
                        let deallocMethod = class_getInstanceMethod(objcClass, deallocSelector)!
                        
                        // Store the existing implementation to `existingImpl` to ensure it is
                        // available before our version is swapped in.
                        existingImp = method_getImplementation(deallocMethod)
                        
                        // Store the swapped-out implementation to `existingImpl` in case
                        // the implementation has been changed concurrently.
                        existingImp = method_setImplementation(deallocMethod, newImp)
                    }
                }
            }
            
            object.cx.setAssociated(tracer, for: AssociateKeys.lifetimeTracer)
            return tracer.lifetime
        }
    }
    
    typealias Output = Void
    typealias Failure = Never
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Void == S.Input {
        self.subject.receive(subscriber: subscriber)
    }
}
