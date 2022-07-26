//
//  OnBoardingSecondViewController.swift
//  Yetda
//
//  Created by Geunil Park on 2022/07/21.
//

import UIKit

class OnBoardingSecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.makeSearchBar()
        self.makeSubtitle1()
        self.makeSubtitle2()
        self.makeOnBoardingButton()
    }
    
    func makeSubtitle1() {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "기념품 구매하셨나요?"
        subtitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 30)
        
        self.view.addSubview(subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.6).isActive = true
    }
    
    func makeSubtitle2() {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "여행지를 입력해주세요"
        subtitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 30)
        
        let attributedStr = NSMutableAttributedString(string: subtitleLabel.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (subtitleLabel.text! as NSString).range(of: "여행지"))
        subtitleLabel.attributedText = attributedStr
        
        self.view.addSubview(subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.6).isActive = true
    }
    
    func makeSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "여행지를 추가해주세요"
        searchBar.searchBarStyle = .minimal
        
        self.view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 170).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.6).isActive = true
    }
    
    func makeOnBoardingButton() {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(moveToHome), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func moveToHome() {
        self.dismiss(animated: true, completion: nil)
    }
}
