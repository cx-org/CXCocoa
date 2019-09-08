@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct CombineXBox<Base> {
    
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol CombineXCompatible { }

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension CombineXCompatible {
    
    public var cx: CombineXBox<Self> {
        return CombineXBox(self)
    }
    
    public static var cx: CombineXBox<Self>.Type {
        return CombineXBox<Self>.self
    }
}
