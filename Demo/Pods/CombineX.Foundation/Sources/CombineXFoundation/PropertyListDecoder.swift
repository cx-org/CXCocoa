import CombineX
import Foundation

#if !os(Linux)
extension PropertyListDecoder: CombineXCompatible { }

extension PropertyListDecoder {
    
    public enum CX { }
}

extension CombineXBox where Base: PropertyListDecoder {
    
    public var decoder: PropertyListDecoder.CX.Decoder {
        return .init(self.base)
    }
}

extension PropertyListDecoder.CX {
    
    public struct Decoder: CombineX.TopLevelDecoder {
        
        let decoder: PropertyListDecoder
        
        init(_ decoder: PropertyListDecoder) {
            self.decoder = decoder
        }
     
        public typealias Input = Data
        
        public func decode<T>(_ type: T.Type, from: Input) throws -> T where T : Decodable {
            return try self.decoder.decode(type, from: from)
        }
    }
}
#endif
