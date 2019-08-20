import CombineXFoundation
import UIKit

extension CombineXBox where Base: UIButton {

    public var tap: ControlEventPublisher<Base> {
        return self.controlEvent(.touchUpInside)
    }
    
    public func title(for state: UIControl.State) -> Binder<String> {
        return Binder(target: self.base) {
            $0.setTitle($1, for: state)
        }
    }
    
    public var title: Binder<String> {
        return self.title(for: .normal)
    }
    
    public func image(for controlState: UIControl.State) -> Binder<UIImage?> {
        return Binder(target: self.base) {
            $0.setImage($1, for: controlState)
        }
    }
    
    public var image: Binder<UIImage?> {
        return self.image(for: .normal)
    }
}
