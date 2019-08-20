//
//  ViewController.swift
//  Demo
//
//  Created by Quentin Jin on 2019/8/14.
//  Copyright © 2019 Quentin Jin. All rights reserved.
//

import UIKit
import CombineXCocoa

class ViewController: UIViewController {

    @IBOutlet weak var keywordTextField: UITextField!
    
    @IBOutlet weak var realTimeStatusLabel: UILabel!
    @IBOutlet weak var realTimeSwitch: UISwitch!
    
    @IBOutlet weak var logTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.realTimeSwitch.cx.isOn
            .map {
                print("switch on", $0)
                return "Real-time Search: " + ($0 ? "ON" : "OFF")
            }
            .bind(to: self.realTimeStatusLabel.cx.text)
            .cancel(by: self)
        
        keywordTextField.cx.text
            .throttle(for: .seconds(0.1), scheduler: DispatchQueue.main.cx.scheduler, latest: true)
            .removeDuplicates()
            .compactMap {
                $0.flatMap { URL(string: "https://api.github.com/search/repositories?q=\($0)") }
            }
            .mapError { $0 as Error }
            .flatMap { url -> Publishers.MapError<NSObject.CX.DataTaskPublisher, Error> in
                URLSession.shared.cx.dataTaskPublisher(for: url).mapError { $0 as Error }
            }
            .sink(receiveCompletion: { (c) in
                print("receive c", c)
            }, receiveValue: { [weak self] v in
                guard let self = self else { return }
                print("receive v", String(bytes: v.data, encoding: .utf8))
            })
            .cancel(by: self)
        
    }
}

