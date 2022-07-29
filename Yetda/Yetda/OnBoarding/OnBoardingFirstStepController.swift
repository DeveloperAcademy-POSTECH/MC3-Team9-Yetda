//
//  OnBoardingFirstViewController.swift
//  Yetda
//
//  Created by Geunil Park on 2022/07/21.
//

import UIKit

class OnBoardingFirstViewController: UIViewController {

    private let leftSide: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.makeTitleLabel()
        self.makeSubtitleLabel1()
        self.makeSubtitleLabel2()
        self.makeOnBoardingImage()
        self.makeOnBoardingButton()
    }
    
    func makeTitleLabel() {
        let titleLabel = UILabel()
        
        titleLabel.text = "옜다!"
        titleLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 30)
        titleLabel.textColor = UIColor(named: "YettdaMainBlue")
        
        self.view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: leftSide).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 1.6).isActive = true
        
    }
    
    func makeSubtitleLabel1() {
        let subTitleLabel = UILabel()
        
        subTitleLabel.text = "소중한 사람에게"
        subTitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 25)
        
        self.view.addSubview(subTitleLabel)
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 345).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: leftSide).isActive = true
        subTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        subTitleLabel.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.6).isActive = true
    }
    
    func makeSubtitleLabel2() {
        let subTitleLabel = UILabel()
        
        subTitleLabel.text = "마음을 담아 선물하세요"
        subTitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 25)
        
        self.view.addSubview(subTitleLabel)
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 382).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: leftSide).isActive = true
        subTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        subTitleLabel.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.6).isActive = true
    }
    
    func makeOnBoardingImage() {
        let imageView: UIImageView
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage(named: "OnBoardingView")
        
        self.view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -1).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.6).isActive = true
    }
    
    func makeOnBoardingButton() {
        let button = UIButton()
        button.setTitle("시작", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(moveToSecondView), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func moveToSecondView() {
        let pageViewController = self.parent as! OnBoardingViewController
        pageViewController.goToNextPage(index: 1)
    }
}
