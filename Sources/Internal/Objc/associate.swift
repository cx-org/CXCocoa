import Foundation

enum AssociateKeys { }

struct AssociateKey<T> {
    let key: UnsafeRawPointer
    
    init() {
        self.key = UnsafeRawPointer(
            UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
        )
    }
    
    init(_ sel: Selector) {
        self.key = UnsafeRawPointer(
            unsafeBitCast(sel, to: UnsafePointer<Int8>.self)
        )
    }
}

extension CombineXBox where Base: AnyObject {
    
    func getAssociated<T>(for key: AssociateKey<T>) -> T? {
        // avoid NSNull
        return objc_getAssociatedObject(self.base, key.key) as! T?
    }
    
    func setAssociated<T>(_ val: T?, for key: AssociateKey<T>) {
        objc_setAssociatedObject(self.base, key.key, val, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

func unsafeSetAssociatedValue<T>(_ value: T?, forKey key: AssociateKey<T>, forObjectAt address: UnsafeRawPointer) {
    _cx_objc_setAssociatedObject(address, key.key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}
