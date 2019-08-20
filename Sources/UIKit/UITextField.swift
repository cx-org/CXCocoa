import UIKit
import CombineXFoundation

extension CombineXBox where Base: UITextField {
    
    public var text: ControlPropertyBinder<String?> {
        return self.controlProperty(
            events: [.allEditingEvents, .valueChanged],
            getter: { $0.text },
            setter: { $0.text = $1 }
        )
    }
}
