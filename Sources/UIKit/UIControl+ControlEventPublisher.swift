import UIKit
import CombineXFoundation

extension CombineXBox where Base: UIControl {
    
    public func controlEvent(_ events: UIControl.Event) -> ControlEventPublisher<Base> {
        return .init(control: self.base, events: events)
    }
}

public struct ControlEventPublisher<Control: UIControl>: Publisher {
    
    public typealias Output = Control
    
    public typealias Failure = Never
    
    public let control: Control
    
    public let events: UIControl.Event
    
    public init(control: Control, events: UIControl.Event) {
        self.control = control
        self.events = events
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        
        let subject = PassthroughSubject<Output, Failure>()
        
        let target = UIControlTarget(control: self.control, events: self.events) {
            subject.send($0)
        }
        
        subject
            .handleEvents(receiveCancel: {
                target.cancel()
            })
            .receive(subscriber: subscriber)
    }
}

private class UIControlTarget<Control: UIControl>: Cancellable {
    
    weak var control: Control?
    
    let events: UIControl.Event
    
    typealias Callback = (Control) -> Void
    var callback: Callback?
    
    init(control: Control, events: UIControl.Event, callback: @escaping Callback) {
        self.control = control
        self.events = events
        self.callback = callback
        
        self.control?.addTarget(self, action: #selector(self.run), for: events)
    }
    
    @objc func run() {
        guard let control = self.control, let callback = self.callback else {
            return
        }
        callback(control)
    }
    
    func cancel() {
        self.control?.removeTarget(self, action: #selector(self.run), for: self.events)
        self.callback = nil
    }
}
