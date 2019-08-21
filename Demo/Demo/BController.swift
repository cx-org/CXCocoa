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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        func log(_ text: String) {
            self.logTextView.text.append(text + "\n")
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
            .map {
                $0.1
            }
            .bind(to: self.tabBarItem.cx.badgeColor)
            .cancel(by: self)
    }
}
