#if canImport(Combine)
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Sequence {
    
    public var cx: CombineXBox<Self> {
        return CombineXBox(self)
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension CombineXBox where Base: Sequence {
    
    public var publisher: Publishers.Sequence<Base, Never> {
        return .init(sequence: self.base)
    }
}

#endif
