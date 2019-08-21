import UIKit
import CombineXFoundation

extension CombineXBox where Base: UIProgressView {
    
    public var progress: UIBinder<Float> {
        return UIBinder(target: self.base) { $0.progress = $1 }
    }
}
