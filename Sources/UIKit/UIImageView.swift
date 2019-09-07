import UIKit

extension CombineXBox where Base: UIImageView {
    
    public var image: UIBinder<UIImage?> {
        return UIBinder(target: self.base) { $0.image = $1 }
    }
    
    public var highlightedImage: UIBinder<UIImage?> {
        return UIBinder(target: self.base) { $0.highlightedImage = $1 }
    }
}
