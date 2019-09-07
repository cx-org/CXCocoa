import UIKit

extension CombineXBox where Base: UIDatePicker {
    
    public var date: ControlPropertyBinder<Date> {
        return self.controlProperty(
            events: .valueChanged,
            getter: { $0.date },
            setter: { $0.date = $1 }
        )
    }
}
