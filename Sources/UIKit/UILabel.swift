import UIKit

extension CombineXBox where Base: UILabel {
    
    public var text: UIBinder<String?> {
        return UIBinder(target: self.base) {
            $0.text = $1
        }
    }
    
    public var attributedText: UIBinder<NSAttributedString?> {
        return UIBinder(target: self.base) {
            $0.attributedText = $1
        }
    }
    
    public var textColor: UIBinder<UIColor> {
        return UIBinder(target: self.base) {
            $0.textColor = $1
        }
    }
}
