import UIKit

extension CombineXWrapper where Base: UITextField {
    
    public var text: ControlProperty<String?> {
        return self.controlProperty(
            events: [.allEditingEvents, .valueChanged],
            getter: { $0.text },
            setter: { $0.text = $1 }
        )
    }
}
