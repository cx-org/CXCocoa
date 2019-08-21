import UIKit
import CombineXFoundation

extension CombineXBox where Base: UITextView {
    
    public var text: UIBinder<String> {
        return UIBinder<String>(target: self.base) {
            $0.text = $1
        }
    }
}
