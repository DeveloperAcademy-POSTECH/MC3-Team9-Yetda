//
//  ViewController.swift
//  Yetda
//
//  Created by Geunil Park on 2022/07/15.
//

import UIKit
import GoogleSignIn
class ViewController: UIViewController {
    
    let isFirstLaunching: Bool = UserDefaults.standard.bool(forKey: "isFirstLaunching")
    
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Storage.isFirstTime() {
            let onBoardingVC = OnBoardingViewController()
            onBoardingVC.modalPresentationStyle = .fullScreen
            
            self.present(onBoardingVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func googleLoginAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
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
