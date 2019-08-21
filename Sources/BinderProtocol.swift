import CombineXFoundation

public protocol Binder {
    
    associatedtype Value
    
    func onNext(_ value: Value)
}

extension Binder {
    
    public func eraseToAnyBinder() -> AnyBinder<Value> {
        return .init(self.onNext)
    }
}

extension Publisher where Failure == Never {
    
    public func bind<B: Binder>(to binder: B) -> AnyCancellable where B.Value == Output {
        return self.sink(receiveValue: { (v) in
            binder.onNext(v)
        })
    }
}


