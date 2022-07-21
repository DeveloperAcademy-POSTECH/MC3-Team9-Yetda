//
//  HomeViewController.swift
//  Yetda
//
//  Created by 이채민 on 2022/07/18.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    let topView = UIView()
    let cardListView = CardListView()
    let planeBtn = UIButton(type: .custom)
    let profileBtn = UIButton(type: .custom)
    let cityLabel = UILabel()
    
    let viewModel = CardListViewModel()
    let disposeBag = DisposeBag()
    
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
        
        self.viewModel.getPresentList()
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
        
//        planeBtn.rx.tap.bind {
//            self.navigationController?.pushViewController(TravelViewController(), animated: true)
//        }.disposed(by: disposeBag)
        
    }
    
    private func setProfileBtn() {
        
//        profileBtn.rx.tap.bind {
//            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
//        }.disposed(by: disposeBag)

        
    }
    
    private func setCityLabel() {
        
    }
    
    private func bindCollectionCardData() {
        
        let collectionView = cardListView.cardCollectionView
        
        viewModel.presentList.bind(to: collectionView.rx.items(cellIdentifier: "PresentCardCell", cellType: CardCell.self)) { row, model, cell in
            print(model)
            cell.setData(model)
        }.disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.bind { indexPath in
            self.cardListView.cardCollectionView.deselectItem(at: indexPath, animated: true)
            guard let present = self.viewModel.getPresentAt(indexPath) else { return }
            self.sendCardData(card: present)
        }.disposed(by: disposeBag)
        
    }
    
    private func sendCardData(card: Present) {
//        let controller = CardDetailViewController()
//        controller.cardId = present.id
//        controller.cardSelected = present
//        self.navigationController!.pushViewController(controller, animated: true)
    }
}
