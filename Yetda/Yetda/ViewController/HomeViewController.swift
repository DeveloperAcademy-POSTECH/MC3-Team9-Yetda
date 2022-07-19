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
import YPImagePicker

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    let topView = UIView()
    let cardListView = CardListView()
    let backgroundImage = UIImageView()
    let planeBtn = UIButton(type: .custom)
    let profileBtn = UIButton(type: .custom)
    let cityLabel = UILabel()
    
    let viewModel = CardListViewModel()
    let disposeBag = DisposeBag()
    
    var imageCount = 0
    
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
        topView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        topView.addSubview(backgroundImage)
        setBackgroundImage()
        topView.addSubview(planeBtn)
        setPlaneBtn()
        topView.addSubview(profileBtn)
        setProfileBtn()
        topView.addSubview(cityLabel)
        setCityLabel()
    }
    
    private func setCardListView() {
        
        
        cardListView.layer.cornerRadius = 20
        cardListView.backgroundColor = UIColor(displayP3Red: 249, green: 250, blue: 253, alpha: 1.0)
        cardListView.clipsToBounds = true
        
        cardListView.translatesAutoresizingMaskIntoConstraints = false
        cardListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cardListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cardListView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 125).isActive = true
        cardListView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        bindCollectionCardData()
    }
    
    private func setBackgroundImage() {
        
        backgroundImage.image = UIImage(named: "HomeViewBG")
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
       
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    private func setPlaneBtn() {
        
        planeBtn.setImage(UIImage(named: "PlaneBtn"), for: .normal)
        
        planeBtn.translatesAutoresizingMaskIntoConstraints = false
        planeBtn.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        planeBtn.topAnchor.constraint(equalTo: topView.topAnchor, constant: 65).isActive = true
        
//        planeBtn.rx.tap.bind {
//            self.navigationController?.pushViewController(TravelViewController(), animated: true)
//        }.disposed(by: disposeBag)
        
    }
    
    private func setProfileBtn() {
        
        profileBtn.setImage(UIImage(named: "ProfileBtn"), for: .normal)
        
        profileBtn.translatesAutoresizingMaskIntoConstraints = false
        profileBtn.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20).isActive = true
        profileBtn.topAnchor.constraint(equalTo: topView.topAnchor, constant: 65).isActive = true
        
//        profileBtn.rx.tap.bind {
//            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
//        }.disposed(by: disposeBag)
        
        profileBtn.rx.tap.bind{
            var config = YPImagePickerConfiguration()
            config.library.maxNumberOfItems = 5 - self.imageCount
            config.library.preSelectItemOnMultipleSelection = false
            config.library.defaultMultipleSelection = true
            config.library.mediaType = .photo
            config.library.isSquareByDefault = false
            config.onlySquareImagesFromCamera = false
            config.hidesCancelButton = false
            
            config.startOnScreen = .library
            
            let imagePicker = YPImagePicker(configuration: config)
            imagePicker.didFinishPicking{[unowned imagePicker] items, _ in
                var newImages:[UIImage] = []
                
                for item in items {
                    switch item{
                    case .photo(let photo):
                        newImages += [photo.image]
                    case .video:
                        print("video is not allowed")
                    }
                    
                }
//                self.selectedImages.accept(self.selectedImages.value+newImages)
                imagePicker.dismiss(animated: true)
            }
            imagePicker.view.backgroundColor = .white
            self.present(imagePicker, animated: true)
        }.disposed(by: disposeBag)

        
    }
    
    private func setCityLabel() {
        
        cityLabel.text = "후쿠오카"
        let font = UIFont.systemFont(ofSize: 25, weight: .bold)
        cityLabel.font = font
        cityLabel.textColor = .white
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.leadingAnchor.constraint(equalTo: planeBtn.leadingAnchor).isActive = true
        cityLabel.topAnchor.constraint(equalTo: planeBtn.bottomAnchor, constant: 20).isActive = true
        
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
