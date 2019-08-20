extension Publisher {
    
    /// Collects up to the specified number of elements, and then emits a single array of the collection.
    ///
    /// If the upstream publisher finishes before filling the buffer, this publisher sends an array of all the items it has received. This may be fewer than `count` elements.
    /// If the upstream publisher fails with an error, this publisher forwards the error to the downstream receiver instead of sending its output.
    /// Note: When this publisher receives a request for `.max(n)` elements, it requests `.max(count * n)` from the upstream publisher.
    /// - Parameter count: The maximum number of received elements to buffer before publishing.
    /// - Returns: A publisher that collects up to the specified number of elements, and then publishes them as an array.
    public func collect(_ count: Int) -> Publishers.CollectByCount<Self> {
        return .init(upstream: self, count: count)
    }
}

extension Publishers.CollectByCount : Equatable where Upstream : Equatable {
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: Publishers.CollectByCount<Upstream>, rhs: Publishers.CollectByCount<Upstream>) -> Bool {
        return lhs.upstream == rhs.upstream && lhs.count == rhs.count
    }
}

extension Publishers {
    
    /// A publisher that buffers a maximum number of items.
    public struct CollectByCount<Upstream> : Publisher where Upstream : Publisher {
        
        /// The kind of values published by this publisher.
        public typealias Output = [Upstream.Output]
        
        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure
        
        /// The publisher from which this publisher receives elements.
        public let upstream: Upstream
        
        ///  The maximum number of received elements to buffer before publishing.
        public let count: Int
        
        public init(upstream: Upstream, count: Int) {
            self.upstream = upstream
            self.count = count
        }
        
        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
        ///
        /// - SeeAlso: `subscribe(_:)`
        /// - Parameters:
        ///     - subscriber: The subscriber to attach to this `Publisher`.
        ///                   once attached it can begin to receive values.
        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == [Upstream.Output] {
            let s = Inner(pub: self, sub: subscriber)
            self.upstream.subscribe(s)
        }
    }

}

extension Publishers.CollectByCount {
    
    private final class Inner<S>:
        Subscription,
        Subscriber,
        CustomStringConvertible,
        CustomDebugStringConvertible
    where
        S: Subscriber,
        S.Input == Output,
        S.Failure == Failure
    {
        
        typealias Input = Upstream.Output
        typealias Failure = Upstream.Failure
        
        typealias Pub = Publishers.CollectByCount<Upstream>
        typealias Sub = S
        
        let lock = Lock()
        let sub: Sub
        let count: Int
        
        var state = RelayState.waiting
        var buffer: [Input] = []
        
        init(pub: Pub, sub: Sub) {
            self.count = pub.count
            self.sub = sub
        
            self.buffer.reserveCapacity(self.count)
        }
        
        func request(_ demand: Subscribers.Demand) {
            self.lock.withLockGet(self.state.subscription)?.request(demand * self.count)
        }
        
        func cancel() {
            self.lock.withLockGet(self.state.complete())?.cancel()
        }
        
        func receive(subscription: Subscription) {
            guard self.lock.withLockGet(self.state.relay(subscription)) else {
                subscription.cancel()
                return
            }
            
            self.sub.receive(subscription: self)
        }
        
        func receive(_ input: Input) -> Subscribers.Demand {
            self.lock.lock()
            guard self.state.isRelaying else {
                self.lock.unlock()
                return .none
            }
            
            self.buffer.append(input)
            
            switch self.buffer.count {
            case self.count:
                let output = self.buffer
                self.buffer.removeAll(keepingCapacity: true)
                self.lock.unlock()
                
                return self.sub.receive(output) * self.count
            default:
                self.lock.unlock()
                return .none
            }
        }
        
        func receive(completion: Subscribers.Completion<Failure>) {
            guard let subscription = self.lock.withLockGet(self.state.complete()) else {
                return
            }
            subscription.cancel()
            
            switch completion {
            case .finished:
                let output = self.buffer
                self.buffer = []
                if !output.isEmpty {
                    _ = self.sub.receive(output)
                }
                self.sub.receive(completion: completion)
            case .failure:
                self.buffer = []
                self.sub.receive(completion: completion)
            }
        }
        
        var description: String {
            return "CollectByCount"
        }
        
        var debugDescription: String {
            return "CollectByCount"
        }
    }
}
