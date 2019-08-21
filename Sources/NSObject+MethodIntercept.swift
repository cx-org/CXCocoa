import Foundation
import CombineX

extension CombineXBox where Base: NSObject {
    
    /// Create a publisher which sends a `next` event at the end of every
    /// invocation of `selector` on the object.
    ///
    /// It completes when the object deinitializes.
    ///
    /// - note: Observers to the resulting signal should not call the method
    ///         specified by the selector.
    ///
    /// - parameters:
    ///   - selector: The selector to observe.
    ///
    /// - returns: A trigger publisher.
    public func methodInvoked(for selector: Selector) -> AnyPublisher<(), Never> {
        return self.base.intercept(selector).map { _ in }.eraseToAnyPublisher()
    }
    
    /// Create a publisher which sends a `next` event, containing an array of
    /// bridged arguments, at the end of every invocation of `selector` on the
    /// object.
    ///
    /// It completes when the object deinitializes.
    ///
    /// - note: Observers to the resulting signal should not call the method
    ///         specified by the selector.
    ///
    /// - parameters:
    ///   - selector: The selector to observe.
    ///
    /// - returns: A publisher that sends an array of bridged arguments.
    public func publish(_ selector: Selector) -> AnyPublisher<[Any?], Never> {
        return self.base.intercept(selector).map(unpackInvocation).eraseToAnyPublisher()
    }
}
