//
//  TestCardShareViewController.swift
//  Yetda
//
//  Created by rbwo on 2022/07/18.
//

import UIKit

class DidCardShareViewController: UIViewController, ShareKaKao {
    @IBOutlet weak var testLabel: UILabel!
    
    lazy var shareButton: UIButton = {
        return configureShareButton(self, action: #selector(shareButtonAction))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: 지금은 Test용
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.testLabel.text = "2"
            
            if self.testLabel.text == "2" {
                let storyboard = UIStoryboard(name: "DidPresent", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DidPresentViewController") as! DidPresentViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
    }
    
    @objc func shareButtonAction(sender: UIButton!) {
        shareKaKao(self, key: "Id", value: "2")
    }
}
