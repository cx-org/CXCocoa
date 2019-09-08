#if canImport(Foundation) && canImport(Combine)
import Foundation

#if os(Linux)
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension DispatchQueue: CombineXCompatible { }

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension DispatchQueue {

    public enum CX { }
}
#endif

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension CombineXBox where Base: DispatchQueue {
    
    var scheduler: DispatchQueue.CX.DispatchQueueScheduler {
        return self.base
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension DispatchQueue.CX {
    
    public typealias DispatchQueueScheduler = DispatchQueue
}

#endif
