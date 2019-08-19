import UIKit
import CombineXFoundation

extension CombineXBox where Base: UILabel {
    
    public var text: Binder<String?> {
        return Binder(target: self.base) {
            $0.text = $1
        }
    }
    
    public var attributedText: Binder<NSAttributedString?> {
        return Binder(target: self.base) {
            $0.attributedText = $1
        }
    }
    
    public var textColor: Binder<UIColor> {
        return Binder(target: self.base) {
            $0.textColor = $1
        }
    }
}
