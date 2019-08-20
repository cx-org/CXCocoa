import UIKit
import CombineXFoundation

extension CombineXBox where Base: UITextView {
    
    public var text: Binder<String> {
        return Binder<String>(target: self.base) {
            $0.text = $1
        }
    }
}
