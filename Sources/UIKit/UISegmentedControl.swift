import UIKit

extension CombineXWrapper where Base: UISegmentedControl {

    public var selectedSegmentIndex: ControlProperty<Int> {
        return self.controlProperty(
            events: [.valueChanged],
            getter: { $0.selectedSegmentIndex },
            setter: { $0.selectedSegmentIndex = $1 }
        )
    }
    
    public func titleForSegment(at index: Int) -> UIBinder<String?> {
        return UIBinder(target: self.base) {
            $0.setTitle($1, forSegmentAt: index)
        }
    }
    
    public func imageForSegment(at index: Int) -> UIBinder<UIImage?> {
        return UIBinder(target: self.base) {
            $0.setImage($1, forSegmentAt: index)
        }
    }
}
