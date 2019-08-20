import CombineX
import Foundation

#if !os(Linux)
extension PropertyListEncoder: CombineXCompatible { }

extension PropertyListEncoder {
    
    public enum CX { }
}

extension CombineXBox where Base: PropertyListEncoder {
    
    public var encoder: PropertyListEncoder.CX.Encoder {
        return .init(self.base)
    }
}

extension PropertyListEncoder.CX {
    
    public struct Encoder: CombineX.TopLevelEncoder {
        
        let encoder: PropertyListEncoder
        
        init(_ encoder: PropertyListEncoder) {
            self.encoder = encoder
        }
     
        public typealias Output = Data
        
        public func encode<T>(_ value: T) throws -> Output where T : Encodable {
            return try self.encoder.encode(value)
        }
    }
}
#endif
