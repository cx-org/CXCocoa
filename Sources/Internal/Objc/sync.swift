import Foundation
import CombineXFoundation

extension CombineXBox where Base: AnyObject {
    
    func sync<T>(_ body: (Base) throws -> T) rethrows -> T {
        objc_sync_enter(self.base); defer { objc_sync_exit(self.base) }
        return try body(self.base)
    }
    
    func sync<T>(_ body: () throws -> T) rethrows -> T {
        objc_sync_enter(self.base); defer { objc_sync_exit(self.base) }
        return try body()
    }
}

extension Global {
    
    static func sync<T>(_ obj: AnyObject, _ body: () throws -> T) rethrows -> T {
        objc_sync_enter(obj); defer { objc_sync_exit(obj) }
        return try body()
    }
}

