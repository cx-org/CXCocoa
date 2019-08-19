import Foundation
import CombineXFoundation

public struct Binder<Value> {

    let action: (Value) -> Void
    
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
    
    public init<Target: AnyObject>(target: Target, action: @escaping (Target, Value) -> Void) {
        self.init(scheduler: UIScheduler.shared, target: target, action: action)
    }
}

extension Publisher where Failure == Never {
    
    public func bind(to binder: Binder<Output>) -> AnyCancellable {
        return self.sink(receiveValue: { v in
            binder.action(v)
        })
    }
}
