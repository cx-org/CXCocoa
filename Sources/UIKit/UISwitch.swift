import UIKit

extension CombineXWrapper where Base: UISwitch {
    
    public var isOn: ControlPropertyBinder<Bool> {
        return self.controlProperty(
            events: .valueChanged,
            getter: { $0.isOn },
            setter: { $0.isOn = $1 }
        )
    }
}
