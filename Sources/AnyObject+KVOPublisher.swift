import Foundation
import CombineXFoundation

extension CombineXBox where Base: AnyObject {
    
    public func kvoPublisher<Value>(_ keyPath: KeyPath<Base, Value>) -> KVOPublisher<Base, Value> {
        return .init(object: self.base, keyPath: keyPath)
    }
    
    public struct KVOPublisher<Object: NSObject, Value>: Publisher {
        public typealias Output = Value?
        public typealias Failure = Never
        
        public let object: Object
        public let keyPath: KeyPath<Object, Value>
        
        public init(object: Object, keyPath: KeyPath<Object, Value>) {
            self.object = object
            self.keyPath = keyPath
        }
        
        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let subject = PassthroughSubject<Output, Never>()
            let observation = self.object.observe(self.keyPath, options: [.new, .initial]) { (_, change) in
                subject.send(change.newValue)
            }
            subject
                .handleEvents(receiveCancel: {
                    observation.invalidate()
                })
                .receive(subscriber: subscriber)
        }
    }
}
