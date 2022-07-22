//
//  ViewController.swift
//  Yetda
//
//  Created by Geunil Park on 2022/07/15.
//

import UIKit

class ViewController: UIViewController {
    
    let isFirstLaunching: Bool = UserDefaults.standard.bool(forKey: "isFirstLaunching")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Storage.isFirstTime() {
            let onBoardingVC = OnBoardingViewController()
            onBoardingVC.modalPresentationStyle = .fullScreen
            
            self.present(onBoardingVC, animated: true, completion: nil)
        }
    }
}

public class Storage {
    static func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
            return true
        } else {
            return false
        }
    }
}
