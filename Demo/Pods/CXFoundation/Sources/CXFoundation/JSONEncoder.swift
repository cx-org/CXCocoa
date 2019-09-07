import CombineX
import Foundation

extension JSONEncoder: CombineXCompatible { }

extension JSONEncoder {
    
    public enum CX { }
}

extension CombineXBox where Base: JSONEncoder {
    
    public var encoder: JSONEncoder.CX.Encoder {
        return .init(self.base)
    }
}

extension JSONEncoder.CX {
    
    public struct Encoder: CombineX.TopLevelEncoder {
        
        let encoder: JSONEncoder
        
        init(_ encoder: JSONEncoder) {
            self.encoder = encoder
        }
     
        public typealias Output = Data
        
        public func encode<T>(_ value: T) throws -> Output where T : Encodable {
            return try self.encoder.encode(value)
        }
    }
}
