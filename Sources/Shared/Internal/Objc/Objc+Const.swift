import Foundation

/// Unavailable selectors in Swift.
enum ObjCSelector {
    case forwardInvocation
    case methodSignatureForSelector
    case `class`
    
    var selector: Selector {
        switch self {
        case .forwardInvocation:            return NSSelectorFromString("forwardInvocation:")
        case .methodSignatureForSelector:   return NSSelectorFromString("methodSignatureForSelector:")
        case .class:                        return NSSelectorFromString("class")
        }
    }
    
    var methodTypeEncoding: UnsafePointer<Int8> {
        switch self {
        case .forwardInvocation:            return StaticString.cPointer(to: "v@:@")
        case .methodSignatureForSelector:   return StaticString.cPointer(to: "v@::")
        case .class:                        return StaticString.cPointer(to: "v@::")
        }
    }
    
    func replaceMethod(in class: AnyClass, imp: IMP) -> IMP? {
        return class_replaceMethod(`class`, self.selector, imp, self.methodTypeEncoding)
    }

    func getMethod(in class: AnyClass) -> IMP? {
        return class_getMethodImplementation(`class`, self.selector)
    }
}


/// Objective-C type encoding.
///
/// The enum does not cover all options, but only those that are expressive in
/// Swift.
enum ObjCTypeEncoding: Int8 {
    case char = 99
    case int = 105
    case short = 115
    case long = 108
    case longLong = 113

    case unsignedChar = 67
    case unsignedInt = 73
    case unsignedShort = 83
    case unsignedLong = 76
    case unsignedLongLong = 81

    case float = 102
    case double = 100

    case bool = 66

    case object = 64
    case type = 35
    case selector = 58

    case undefined = -1
}
