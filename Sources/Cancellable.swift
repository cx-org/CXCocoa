import CombineX

extension Cancellable where Self: AnyObject {

    public func cancel(by object: AnyObject) {
        Lifetime.of(object).subscribe(AnySubscriber(receiveCompletion: { (_) in
            self.cancel()
        }))
    }
}
