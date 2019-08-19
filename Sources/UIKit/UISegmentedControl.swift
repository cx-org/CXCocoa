import CombineXFoundation
import UIKit

extension CombineXBox where Base: UISegmentedControl {

    public var selectedSegmentIndex: ControlPropertyBinder<Int> {
        return self.controlProperty(
            events: [.valueChanged],
            getter: { $0.selectedSegmentIndex },
            setter: { $0.selectedSegmentIndex = $1 }
        )
    }
    
    public func titleForSegment(at index: Int) -> Binder<String?> {
        return Binder(target: self.base) {
            $0.setTitle($1, forSegmentAt: index)
        }
    }
    
    public func imageForSegment(at index: Int) -> Binder<UIImage?> {
        return Binder(target: self.base) {
            $0.setImage($1, forSegmentAt: index)
        }
    }
}
