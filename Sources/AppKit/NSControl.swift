import AppKit

extension CombineXWrapper where Base: NSControl {
    
    public var isEnabled: UIBinder<Bool> {
        return UIBinder(target: self.base) {
            $0.isEnabled = $1
        }
    }
}
