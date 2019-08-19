import Foundation
import CombineX

private extension AssociateKeys {
    
    static let isSwizzled = AssociateKey<Bool>()
    
    static let knownClass = AssociateKey<AnyClass>()
}

extension NSObject {
    
    /// Swizzle the given selectors.
    ///
    /// - warning: The swizzling **does not** apply on a per-instance basis. In
    ///            other words, repetitive swizzling of the same selector would
    ///            overwrite previous swizzling attempts, despite a different
    ///            instance being supplied.
    ///
    /// - parameters:
    ///   - pairs: Tuples of selectors and the respective implementions to be
    ///            swapped in.
    ///   - key: An association key which determines if the swizzling has already
    ///          been performed.
    func swizzle(_ pairs: (Selector, Any)..., key hasSwizzledKey: AssociateKey<Bool>) {
        let subclass: AnyClass = swizzleClass(self)

        Global.sync(subclass) {
            let subclassBox = CombineXBox(subclass as AnyObject)
            if subclassBox.getAssociated(for: hasSwizzledKey) == nil {
                subclassBox.setAssociated(true, for: hasSwizzledKey)
                
                for (selector, body) in pairs {
                    let method = class_getInstanceMethod(subclass, selector)!
                    let typeEncoding = method_getTypeEncoding(method)!

                    if method_getImplementation(method) == _cx_objc_msgForward {
                        let succeeds = class_addMethod(subclass, selector.interopAlias, imp_implementationWithBlock(body), typeEncoding)
                        precondition(succeeds, "CombineX attempts to swizzle a selector that has message forwarding enabled with a runtime injected implementation. This is unsupported in the current version.")
                    } else {
                        let succeeds = class_addMethod(subclass, selector, imp_implementationWithBlock(body), typeEncoding)
                        precondition(succeeds, "CombineX attempts to swizzle a selector that has already a runtime injected implementation. This is unsupported in the current version.")
                    }
                }
            }
        }
    }
}

/// ISA-swizzle the class of the supplied instance.
///
/// - note: If the instance has already been isa-swizzled, the swizzling happens
///         in place in the runtime subclass created by external parties.
///
/// - warning: The swizzling **does not** apply on a per-instance basis. In
///            other words, repetitive swizzling of the same selector would
///            overwrite previous swizzling attempts, despite a different
///            instance being supplied.
///
/// - parameters:
///   - instance: The instance to be swizzled.
///
/// - returns: The runtime subclass of the perceived class of the instance.
func swizzleClass(_ instance: NSObject) -> AnyClass {
    if let knownClass = instance.cx.getAssociated(for: AssociateKeys.knownClass) {
        return knownClass
    }
    
    let objcClass: AnyClass = instance.objcClass
    let realClass: AnyClass = object_getClass(instance)!
    let realClassBox = CombineXBox(realClass as AnyObject)

    if objcClass != realClass {
        // If the class is already lying about what it is, it's probably a KVO
        // dynamic subclass or something else that we shouldn't subclass at runtime.
        Global.sync(realClass) {
            let isSwizzled = realClassBox.getAssociated(for: AssociateKeys.isSwizzled) ?? false
            if !isSwizzled {
                replaceGetClass(of: realClass, with: objcClass)
                realClassBox.setAssociated(true, for: AssociateKeys.isSwizzled)
            }
        }

        return realClass
    } else {
        let name = String(cString: class_getName(objcClass)).appending("_CombineXSwift")
        let subclass: AnyClass = name.withCString { cString in
            if let existingClass = objc_getClass(cString) as! AnyClass? {
                return existingClass
            } else {
                let subclass: AnyClass = objc_allocateClassPair(objcClass, cString, 0)!
                replaceGetClass(of: subclass, with: objcClass)
                objc_registerClassPair(subclass)
                return subclass
            }
        }

        object_setClass(instance, subclass)
        instance.cx.setAssociated(subclass, for: AssociateKeys.knownClass)
        return subclass
    }
}

/// Swizzle the `-class` and `+class` methods.
private func replaceGetClass(of a: AnyClass, with b: AnyClass) {
    let getClass: @convention(block) (UnsafeRawPointer?) -> AnyClass = { _ in
        return b
    }

    let impl = imp_implementationWithBlock(getClass as Any)
    
    let sel = ObjCSelector.class
    _ = class_replaceMethod(a,
                            sel.selector,
                            impl,
                            sel.methodTypeEncoding)

    _ = class_replaceMethod(object_getClass(a),
                            sel.selector,
                            impl,
                            sel.methodTypeEncoding)
}
