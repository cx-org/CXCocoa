import UIKit
import CombineXFoundation

extension CombineXBox where Base: UIControl {
    
    public func controlProperty<Value>(
        events: UIControl.Event,
        getter: @escaping (Base) -> Value,
        setter: @escaping (Base, Value) -> Void
    )
        -> ControlPropertyBinder<Value>
    {
        let subject = CurrentValueSubject<Value, Never>(getter(self.base))
        self.controlEvent(events).map(getter).subscribe(subject).cancel(by: self.base)
        let binder = Binder<Value>(target: self.base, action: setter)
        return .init(publisher: subject.eraseToAnyPublisher(), binder: binder)
    }
    
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
    
    public func bind(to binder: CombineXBox<UIControl>.ControlPropertyBinder<Output>) -> AnyCancellable {
        return self.bind(to: binder.binder)
    }
}
