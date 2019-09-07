import CombineX
import Foundation

extension JSONDecoder: CombineXCompatible { }

extension JSONDecoder {
    
    public enum CX { }
}

extension CombineXBox where Base: JSONDecoder {
    
    public var decoder: JSONDecoder.CX.Decoder {
        return .init(self.base)
    }
}

extension JSONDecoder.CX {
    
    public struct Decoder: CombineX.TopLevelDecoder {
        
        let decoder: JSONDecoder
        
        init(_ decoder: JSONDecoder) {
            self.decoder = decoder
        }
     
        public typealias Input = Data
        
        public func decode<T>(_ type: T.Type, from: Input) throws -> T where T : Decodable {
            return try self.decoder.decode(type, from: from)
        }
    }
}
