#if canImport(Foundation) && canImport(Combine)
import Foundation

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension NSObject: CombineXCompatible { }

extension NSObject {
    
    public enum CX { }
}

#if canImport(ObjectiveC)
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension NSObject.CX {
    
    public typealias KeyValueObservingPublisher = NSObject.KeyValueObservingPublisher
}
#endif

#endif
