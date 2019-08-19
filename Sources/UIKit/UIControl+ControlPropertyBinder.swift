import UIKit
import CombineXFoundation

extension CombineXBox where Base: UIControl {
    
    public func controlProperty<Value>(
        events: UIControl.Event,
        getter: @escaping (Base) -> Value,
        setter: @escaping (Base, Value) -> Void
    )
        -> UIControl.CX.ControlPropertyBinder<Value>
    {
        let pub = self.controlEvent(events).map(getter).eraseToAnyPublisher()
        let binder = Binder<Value>(target: self.base, action: setter)
        return .init(publisher: pub, binder: binder)
    }
}

public typealias ControlPropertyBinder = UIControl.CX.ControlPropertyBinder

extension UIControl.CX {
    
    public struct ControlPropertyBinder<Value>: Publisher {
        public typealias Output = Value
        public typealias Failure = Never
        
        fileprivate let publisher: AnyPublisher<Value, Never>
        fileprivate let binder: Binder<Value>
        
        fileprivate init(publisher: AnyPublisher<Value, Never>, binder: Binder<Value>) {
            self.publisher = publisher
            self.binder = binder
        }
        
        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            self.publisher.receive(subscriber: subscriber)
        }
    }
}

extension Publisher where Failure == Never {
    
    public func bind(to binder: UIControl.CX.ControlPropertyBinder<Output>) -> AnyCancellable {
        return self.bind(to: binder.binder)
    }
}
