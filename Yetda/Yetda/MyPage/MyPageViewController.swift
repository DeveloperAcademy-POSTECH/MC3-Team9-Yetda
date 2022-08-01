//
//  MyPageViewController.swift
//  Yetda
//
//  Created by 김보승 on 2022/07/28.
//

import UIKit
import SafariServices
import FirebaseAuth

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var myPageNavi: UINavigationBar!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var resignButton: UIButton!
    @IBOutlet weak var informButton: UIButton!
    @IBOutlet weak var doneButtonNaviBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "YettdaMainBackground")
    }
    
    @IBAction func forDismissButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func logoutAlert(_ sender: UIButton) {
        let logoutalert = UIAlertController(title: "로그아웃 확인", message: "로그아웃 하시겠어요?", preferredStyle: .alert)
        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
        let logout = UIAlertAction(title: "로그아웃", style: .destructive) { UIAlertAction in
            let firebaseAuth = Auth.auth()
            
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print("ERROR: singout \(signOutError.localizedDescription)")
            }
            
            print("로그아웃 로직 짜야함")
        }
        logoutalert.addAction(cancle)
        logoutalert.addAction(logout)
        present(logoutalert, animated: true)
    }
    
    @IBAction func forResginButton(_ sender: UIButton) {
        let resignAlert = UIAlertController(title: "회원탈퇴 확인", message: "회원탈퇴시 지금까지 기록된 데이터가 사라집니다", preferredStyle: .alert)
        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
        let resign = UIAlertAction(title: "", style: .destructive) { UIAlertAction in
            print("회원탈퇴 로직 짜야함")
        }
        resignAlert.addAction(cancle)
        resignAlert.addAction(resign)
        present(resignAlert, animated: true)
    }
    @IBAction func presentInfo(_ sender: Any) {
        guard let url = URL(string: "https://github.com/DeveloperAcademy-POSTECH/MC3-Team9-Yetda") else {
            return
        }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
}
