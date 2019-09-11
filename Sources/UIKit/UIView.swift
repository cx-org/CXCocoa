import UIKit

extension CombineXWrapper where Base: UIView {
    
    public var isHidden: UIBinder<Bool> {
        return UIBinder(target: self.base) {
            $0.isHidden = $1
        }
    }
    
    public var alpha: UIBinder<CGFloat> {
        return UIBinder(target: self.base) {
            $0.alpha = $1
        }
    }
    
    public var backgroundColor: UIBinder<UIColor?> {
        return UIBinder(target: self.base) {
            $0.backgroundColor = $1
        }
    }
}
