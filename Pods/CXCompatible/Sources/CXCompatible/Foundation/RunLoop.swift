#if canImport(Foundation) && canImport(Combine)
import Foundation

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension CombineXBox where Base: RunLoop {

    public var scheduler: RunLoop.CX.RunLoopScheduler {
        return self.base
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension RunLoop.CX {
    
    public typealias RunLoopScheduler = RunLoop
}

#endif
