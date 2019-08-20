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

    @IBOutlet weak var langSeg: UISegmentedControl!
    @IBOutlet weak var isOnSwitch: UISwitch!
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var logTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let langPub = langSeg.cx.selectedSegmentIndex
            .map {
                ["swift", "javascript", "go"][$0]
            }

        isOnSwitch.cx.isOn
            .compactMap {
                $0 ? nil : ""
            }
            .bind(to: self.logTextView.cx.text)
            .cancel(by: self)
        
        keywordTextField.cx.text
            .throttle(for: .seconds(0.1), scheduler: DispatchQueue.main.cx.scheduler, latest: true)
            .combineLatest(langPub, isOnSwitch.cx.isOn)
            .compactMap { (name, lang, isOn) -> URL? in
                guard isOn else { return nil }
                return name.flatMap {
                    $0.count > 3 ? URL(string: "https://api.github.com/search/repositories?q=\($0)+language:\(lang)") : nil
                }
            }
            .removeDuplicates()
            .mapError { $0 as Error }
            .map {
                return URLSession.shared.cx.dataTaskPublisher(for: $0).mapError { $0 as Error }
            }
            .switchToLatest()
            .map {
                processSearchResult($0.data)
            }
            .replaceError(with: "Bad response.")
            .bind(to: self.logTextView.cx.text)
            .cancel(by: self)
    }
}

private func processSearchResult(_ data: Data) -> String {
    guard
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
        let items = json["items"] as? [[String: Any]]
    else {
        return "Bad response."
    }
    
    return items
        .compactMap { dict -> String? in
            guard let name = dict["name"] as? String, let star = dict["stargazers_count"] as? Int else {
                return nil
            }
            return name + "(star: \(star))\n"
        }
        .reduce(into: "", { (r, v) in
            r.append(contentsOf: v)
        })
    
}
