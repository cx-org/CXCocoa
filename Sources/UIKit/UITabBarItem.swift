import CombineXFoundation
import UIKit

extension CombineXBox where Base: UITabBarItem {
    
    public var badgeValue: UIBinder<String?> {
        return UIBinder(target: self.base) { $0.badgeValue = $1 }
    }
    
    public var badgeColor: UIBinder<UIColor?> {
        return UIBinder(target: self.base) { $0.badgeColor = $1 }
    }
}
