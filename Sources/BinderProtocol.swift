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
    
    public func bindTo<B1: Binder, B2: Binder>(_ b1: B1, _ b2: B2) -> AnyCancellable where Output == (B1.Value, B2.Value) {
        return self.sink(receiveValue: {
            b1.onNext($0.0)
            b2.onNext($0.1)
        })
    }
    
    public func bindTo<B1: Binder, B2: Binder, B3: Binder>(_ b1: B1, _ b2: B2, _ b3: B3) -> AnyCancellable where Output == (B1.Value, B2.Value, B3.Value) {
        return self.sink(receiveValue: {
            b1.onNext($0.0)
            b2.onNext($0.1)
            b3.onNext($0.2)
        })
    }
}


