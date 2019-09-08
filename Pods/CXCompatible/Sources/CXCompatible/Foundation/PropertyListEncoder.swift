#if canImport(Foundation) && canImport(Combine)
import Foundation

#if !os(Linux)
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension PropertyListEncoder: CombineXCompatible { }

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension PropertyListEncoder {
    
    public enum CX { }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension CombineXBox where Base: PropertyListEncoder {
    
    public var encoder: PropertyListEncoder.CX.Encoder {
        return self.base
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension PropertyListEncoder.CX {
    
    public typealias Encoder = PropertyListEncoder
}
#endif

#endif
