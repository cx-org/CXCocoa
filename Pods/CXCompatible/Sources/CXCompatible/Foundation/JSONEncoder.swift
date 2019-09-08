#if canImport(Foundation) && canImport(Combine)
import Foundation

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension JSONEncoder: CombineXCompatible { }

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension JSONEncoder {
    
    public enum CX { }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension CombineXBox where Base: JSONEncoder {
    
    public var encoder: JSONEncoder.CX.Encoder {
        return self.base
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension JSONEncoder.CX {
    
    public typealias Encoder = JSONEncoder
}

#endif
