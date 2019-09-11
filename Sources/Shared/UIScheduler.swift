import Foundation

public class UIScheduler: Scheduler {

    public typealias SchedulerOptions = RunLoopCXWrapper.SchedulerOptions
    public typealias SchedulerTimeType = RunLoopCXWrapper.SchedulerTimeType
    
    public static let shared = UIScheduler()
    
    private init() { }
    
    private let queueLength = Atom<Int>(val: 0)
    private let scheduler = RunLoop.main.cx
    
    public var now: SchedulerTimeType {
        return self.scheduler.now
    }
    
    public var minimumTolerance: SchedulerTimeType.Stride {
        return self.scheduler.minimumTolerance
    }

    public func schedule(options: SchedulerOptions?, _ action: @escaping () -> Void) {
        if queueLength.add(1) == 0 && DispatchQueue.isMainQueue {
            action()
            _ = queueLength.sub(1)
            return
        }
        self.scheduler.schedule(options: options, action)
    }
    
    public func schedule(after date: SchedulerTimeType, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) {
        self.scheduler.schedule(after: date, tolerance: tolerance, options: options, action)
    }
    
    public func schedule(after date: SchedulerTimeType, interval: SchedulerTimeType.Stride, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable {
        return self.scheduler.schedule(after: date, interval: interval, tolerance: tolerance, options: options, action)
    }
}
