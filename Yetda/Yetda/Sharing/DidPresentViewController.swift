//
//  DidPresentViewController.swift
//  Yetda
//
//  Created by rbwo on 2022/07/18.
//

import UIKit

class DidPresentViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = UIImage(named: "background")
    }
    
    @IBAction func clickedBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func clickedNextButton(_ sender: Any) {
        // MARK: HomeView로 가는 버튼 구현
        guard let pvc = self.presentingViewController as? UINavigationController else { return }
        self.dismiss(animated: false) {
            pvc.popViewController(animated: false)
        }
    }
}
