import CombineXFoundation
import UIKit

extension CombineXBox where Base: UIButton {

    public var tap: ControlEventPublisher<Base> {
        return self.controlEvent(.touchUpInside)
    }
    
    public func title(for state: UIControl.State) -> UIBinder<String> {
        return UIBinder(target: self.base) {
            $0.setTitle($1, for: state)
        }
    }
    
    public var title: UIBinder<String> {
        return self.title(for: .normal)
    }
    
    public func image(for controlState: UIControl.State) -> UIBinder<UIImage?> {
        return UIBinder(target: self.base) {
            $0.setImage($1, for: controlState)
        }
    }
    
    public var image: UIBinder<UIImage?> {
        return self.image(for: .normal)
    }
}
