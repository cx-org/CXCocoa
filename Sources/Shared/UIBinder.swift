
public struct UIBinder<Value>: Binder {
    
    private let binder: AnyBinder<Value>
    
    public func onNext(_ value: Value) {
        self.binder.onNext(value)
    }
    
    public init<Target: AnyObject>(target: Target, action: @escaping (Target, Value) -> Void) {
        self.binder = .init(scheduler: UIScheduler.shared, target: target, action: action)
    }
}
