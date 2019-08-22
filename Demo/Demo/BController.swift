//
//  BController.swift
//  Demo
//
//  Created by Quentin Jin on 2019/8/21.
//  Copyright © 2019 Quentin Jin. All rights reserved.
//

import UIKit

class BController: UIViewController {
    
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var colorSegControl: UISegmentedControl!
    @IBOutlet weak var logTextView: UITextView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
        
        func log(_ text: String) {
            self.logTextView.text.append(text + "\n")
            self.logTextView.scrollsToBottom()
        }

        self.activityButton.cx.tap
            .scan(false) { (f, _) in
                return !f
            }
            .handleEvents(receiveOutput: { [weak self] active in
                let map = [true: "stop", false: "start"]
                let title = map[active]
                self?.activityButton.setTitle(title, for: .normal)
                log("[Button]: \(map[!active]!)")
            })
            .bind(to: self.activityIndicator.cx.isAnimating)
            .cancel(by: self)
        
        self.datePicker.cx.date
            .map {
                "\(Int($0.timeIntervalSinceReferenceDate / 60 / 60 / 24))"
            }
            .handleEvents(receiveOutput: { date in
                log("[DatePicker]: \(date!)")
            })
            .bind(to: self.tabBarItem.cx.badgeValue)
            .cancel(by: self)
        
        self.colorSegControl.cx.selectedSegmentIndex
            .map {
                ($0, [UIColor.red, UIColor.green, UIColor.blue][$0])
            }
            .handleEvents(receiveOutput: { (idx, _) in
                let color = ["Red", "Green", "Blue"][idx]
                log("[Segmented]: \(color)")
            })
            .bindTo(self.pickerView.cx.selectedRow(inComponent: 0), self.tabBarItem.cx.badgeColor)
            .cancel(by: self)
        
        self.pickerView.cx.didSelect
            .map {
                ($0.row, [UIColor.red, UIColor.green, UIColor.blue][$0.row])
            }
            .handleEvents(receiveOutput: { (idx, _) in
                let color = ["Red", "Green", "Blue"][idx]
                log("[PickerView]: \(color)")
            })
            .bindTo(self.colorSegControl.cx.selectedSegmentIndex, self.tabBarItem.cx.badgeColor)
            .cancel(by: self)
    }
}

extension BController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ["RED", "GREEN", "BLUE"][row]
    }
}

extension UITextView {
    
    func scrollsToBottom() {
        guard let text = self.text else { return }
        self.scrollRangeToVisible(NSRange(location: text.count - 1, length: 1))
    }
}
