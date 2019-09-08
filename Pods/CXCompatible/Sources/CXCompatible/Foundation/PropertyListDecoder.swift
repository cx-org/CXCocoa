#if canImport(Foundation) && canImport(Combine)
import Foundation

#if !os(Linux)
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension PropertyListDecoder: CombineXCompatible { }

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension PropertyListDecoder {
    
    public enum CX { }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension CombineXBox where Base: PropertyListDecoder {
    
    public var decoder: PropertyListDecoder.CX.Decoder {
        return self.base
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension PropertyListDecoder.CX {
    
    public typealias Decoder = PropertyListDecoder
}
#endif

#endif
