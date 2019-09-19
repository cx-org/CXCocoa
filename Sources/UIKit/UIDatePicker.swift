import UIKit

extension CombineXWrapper where Base: UIDatePicker {
    
    public var date: ControlProperty<Date> {
        return self.controlProperty(
            events: .valueChanged,
            getter: { $0.date },
            setter: { $0.date = $1 }
        )
    }
}
