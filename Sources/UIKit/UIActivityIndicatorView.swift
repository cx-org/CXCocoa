import UIKit

extension CombineXWrapper where Base: UIActivityIndicatorView {
    
    public var isAnimating: UIBinder<Bool> {
        return UIBinder(target: self.base) { $1 ? $0.startAnimating() : $0.stopAnimating() }
    }
}
