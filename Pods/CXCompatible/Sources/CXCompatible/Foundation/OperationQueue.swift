#if canImport(Foundation) && canImport(Combine)
import Foundation

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension CombineXBox where Base: OperationQueue {
    
    public var scheduler: OperationQueue.CX.OperationQueueScheduler {
        return self.base
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension OperationQueue.CX {
    
    public typealias OperationQueueScheduler = OperationQueue
}

#endif
