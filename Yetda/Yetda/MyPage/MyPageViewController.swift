//
//  MyPageViewController.swift
//  Yetda
//
//  Created by 김보승 on 2022/07/28.
//

import UIKit



class MyPageViewController: UIViewController {
    
    @IBOutlet weak var myPageNavi: UINavigationBar!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var resignButton: UIButton!
    @IBOutlet weak var informButton: UIButton!
    @IBOutlet var myPageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonwidth: CGFloat = UIScreen.main.bounds.width - 40
        let buttonheight: CGFloat = (logoutButton.titleLabel?.bounds.height)! + 22

        logoutButton.frame.size.height = buttonheight
        logoutButton.frame.size.width = buttonwidth
        logoutButton.tintColor = UIColor(.gray)
        
        resignButton.tintColor = UIColor(.gray)
        informButton.tintColor = UIColor(.gray)


        // Do any additional setup after loading the view.
    }
    

 
}
