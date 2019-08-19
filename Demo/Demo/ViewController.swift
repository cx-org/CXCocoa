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
    @IBOutlet weak var logTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keywordTextField.cx
            .text
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
            }, receiveValue: { [weak self] v in
                guard let self = self else { return }
            })
            .cancel(by: self)
        
    }
}

