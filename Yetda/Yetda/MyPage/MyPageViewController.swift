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
    @IBOutlet weak var doneButtonNaviBar: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoutButton = UIButton()
        let resignButton = UIButton()
        let informButton = UIButton()
        
        self.view.backgroundColor = UIColor(named: "YettdaMainBackground")
        self.view.addSubview(logoutButton)
        self.view.addSubview(resignButton)
        self.view.addSubview(informButton)
        
        
        let buttonwidth: CGFloat = UIScreen.main.bounds.width - 40
        let buttonheight: CGFloat = 39

        logoutButton.frame.size.height = buttonheight
        logoutButton.frame.size.width = buttonwidth
        
        // Do any additional setup after loading the view.
    }
    @IBAction func forDismissButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func logoutAlert(_ sender: UIButton) {
        let logoutalert = UIAlertController(title: "로그아웃 확인", message: "로그아웃 하시겠어요?", preferredStyle: .alert)
        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
        let logout = UIAlertAction(title: "로그아웃", style: .destructive, handler: nil)
        logoutalert.addAction(cancle)
        logoutalert.addAction(logout)
        present(logoutalert, animated: true)
    }
    
    @IBAction func forResginButton(_ sender: UIButton) {
        let resignAlert = UIAlertController(title: "회원탈퇴 확인", message: "회원탈퇴시 지금까지 기록된 데이터가 사라집니다", preferredStyle: .alert)
        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
        let resign = UIAlertAction(title: "로그아웃", style: .destructive, handler: nil)
        resignAlert.addAction(cancle)
        resignAlert.addAction(resign)
        present(resignAlert, animated: true)
    }
    
    
    
}
