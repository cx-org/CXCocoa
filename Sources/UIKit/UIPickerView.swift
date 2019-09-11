import UIKit

private class PickerViewDelegateProxy: DelegateProxy<UIPickerViewDelegate>, UIPickerViewDelegate {
    @objc func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        forwardee?.pickerView?(pickerView, didSelectRow: row, inComponent: component)
    }
}

extension CombineXWrapper where Base: UIPickerView {
    
    private var proxy: PickerViewDelegateProxy {
        return .proxy(for: base,
                      setter: #selector(setter: base.delegate),
                      getter: #selector(getter: base.delegate))
    }
    
    public func selectedRow(inComponent component: Int) -> UIBinder<Int> {
        return UIBinder(target: self.base) { $0.selectRow($1, inComponent: component, animated: false) }
    }
    
    public var reloadAllComponents: UIBinder<()> {
        return UIBinder(target: self.base) { base, _ in base.reloadAllComponents() }
    }
    
    public var reloadComponent: UIBinder<Int> {
        return UIBinder(target: self.base) { $0.reloadComponent($1) }
    }
    
    public var didSelect: AnyPublisher<(row: Int, component: Int), Never> {
        return self.proxy.intercept(#selector(UIPickerViewDelegate.pickerView(_:didSelectRow:inComponent:)))
            .map { (row: $0[1] as! Int, component: $0[2] as! Int) }
            .eraseToAnyPublisher()
    }
}
