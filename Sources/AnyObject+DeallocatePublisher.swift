import Foundation
import CombineXFoundation

private extension AssociateKeys {
    
    static let deallocate = AssociateKey<CombineXBox<AnyObject>.DeallocatePublisher>()
}

extension CombineXBox where Base: AnyObject {
    
    public var deallocate: DeallocatePublisher {
        return .init(self.base)
    }
    
    public struct DeallocatePublisher: Publisher {
        
        public typealias Output = Void
        public typealias Failure = Never
        
        let lifetime: Lifetime
        
        init(_ lifetime: Lifetime) {
            self.lifetime = lifetime
        }
        
        public init(_ object: AnyObject) {
            self.lifetime = Lifetime.of(object)
        }
        
        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            self.lifetime.receive(subscriber: subscriber)
        }
    }

}
