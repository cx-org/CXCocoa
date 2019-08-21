import Foundation
import CombineXFoundation

public struct AnyBinder<Value>: Binder {

    private let action: (Value) -> Void
    
    public init(_ onNext: @escaping (Value) -> Void) {
        self.action = onNext
    }
    
    public func onNext(_ value: Value) {
        self.action(value)
    }
}

extension AnyBinder {
    
    public init<S: Scheduler, Target: AnyObject>(scheduler: S, target: Target, action: @escaping (Target, Value) -> Void) {
        weak var weakTarget = target
        
        self.action = { value in
            scheduler.schedule {
                guard let target = weakTarget else {
                    return
                }
                action(target, value)
            }
        }
    }
}
