//
//  HomeViewController.swift
//  Yetda
//
//  Created by 이채민 on 2022/07/18.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    let topView = UIView()
    let cardListView = CardListView()
    let viewModel = CardListViewModel()
    let planeBtn = UIButton(type: .custom)
    let profileBtn = UIButton(type: .custom)
    let cityLabel = UILabel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(topView)
        setTopView()
        self.view.addSubview(cardListView)
        setCardListView()
        
        // TODO: viewModel에서 리스트 가져오기
    }
    
    private func setTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        // TODO: 색상 말고 디자인 배경 삽입
        topView.backgroundColor = .blue
        
        topView.addSubview(planeBtn)
        setPlaneBtn()
        topView.addSubview(profileBtn)
        setProfileBtn()
        topView.addSubview(cityLabel)
        setCityLabel()
    }
    
    private func setCardListView() {
        cardListView.translatesAutoresizingMaskIntoConstraints = false
        cardListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cardListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cardListView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        cardListView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        cardListView.layer.cornerRadius = 20
        
        bindCollectionCardData()
    }
    
    private func setPlaneBtn() {
        
    }
    
    private func setProfileBtn() {
        
    }
    
    private func setCityLabel() {
        
    }
    
    private func bindCollectionCardData() {
        
        let collectionView = cardListView.cardCollectionView
        // TODO: collectionView 바인딩
    }
    
    private func sendCardData(card: Present) {
        // TODO: 디테일 뷰로 데이터 보내주기
    }
}
