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
import Hero
import FirebaseFirestore

class HomeViewController: UIViewController {

    var sampleCards = BehaviorRelay<[String]>(value: [" . ", "Aichi.png", "Akita.png", "Aomori.png", "Chiba.png", "Ehime.png", "Fukui.png"])
    var db = Firestore.firestore()
    
    var presents: [Present] = []
    
    let topView = UIView()
    let cardListView = CardListView()
    let cardCell = CardCell()
    let backgroundImage = UIImageView()
    let planeBtn = UIButton(type: .custom)
    let profileBtn = UIButton(type: .custom)
    let cityLabel = UILabel()
    lazy var menuItems: [UIAction] = {
        return [
            UIAction(title: "이름변경", image: nil, state: .off, handler: { _ in }),
            UIAction(title: "로그아웃", image: nil, state: .off, handler: { _ in }),
            UIAction(title: "회원탈퇴", image: nil, state: .off, handler: { _ in })
        ]
    }()
    
    let viewModel = CardListViewModel()
    let disposeBag = DisposeBag()
    
    var imageList: [UIImage] = []
    var imageCount = 0
    var longPressEnabled = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let showOnBoarding = defaults.bool(forKey: "isFirst")
        if !showOnBoarding {
            self.navigationController?.pushViewController(OnBoardingViewController(), animated: false)
        }
    }
    
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
        
        self.isHeroEnabled = true
        self.cardListView.hero.id = defaults.string(forKey: "site")
        self.hero.modalAnimationType = .fade
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
        cardListView.cardCollectionView.addGestureRecognizer(longPressGesture)
        
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        self.topView.addGestureRecognizer(touchGesture)
        
        // Firestore DB 읽기
//        db.collection("presents").addSnapshotListener { snapshot, error in
//            guard let documents = snapshot?.documents else {
//                print("ERROR Firestore fetching document \(String(describing: error?.localizedDescription))")
//                return
//            }
//
//            self.presents = documents.compactMap { doc -> Present? in
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
//                    let present = try JSONDecoder().decode(Present.self, from: jsonData)
//                    return present
//                } catch let error {
//                    print("ERROR JSON Parsing \(error)")
//                    return nil
//                }
//            }
//            print(self.presents)
//        }
    }
    
    @objc func longTap(_ gesture: UIGestureRecognizer) {
        
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = cardListView.cardCollectionView.indexPathForItem(at: gesture.location(in: cardListView.cardCollectionView)) else { return }
            cardListView.cardCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            
        case .changed:
            cardListView.cardCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            
        case .ended:
            cardListView.cardCollectionView.endInteractiveMovement()
            longPressEnabled = true
            self.cardListView.cardCollectionView.reloadData()
            
        default:
            cardListView.cardCollectionView.cancelInteractiveMovement()
            
        }
    }
    
    @objc func tap(_ gesture: UIGestureRecognizer) {
        longPressEnabled = false
        self.cardListView.cardCollectionView.reloadData()
    }
    
    private func setTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        topView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
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
        cardListView.layer.cornerRadius = 30
        cardListView.backgroundColor = UIColor(displayP3Red: 249/255, green: 250/255, blue: 253/255, alpha: 1.0)
        cardListView.clipsToBounds = true
        
        cardListView.translatesAutoresizingMaskIntoConstraints = false
        cardListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cardListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cardListView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 90).isActive = true
        cardListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
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
        
        planeBtn.rx.tap.bind {
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
        
    }
    
    private func setProfileBtn() {
        profileBtn.setImage(UIImage(named: "ProfileBtn"), for: .normal)
        
        profileBtn.translatesAutoresizingMaskIntoConstraints = false
        profileBtn.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20).isActive = true
        profileBtn.topAnchor.constraint(equalTo: topView.topAnchor, constant: 65).isActive = true
        
        profileBtn.menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: menuItems)
        profileBtn.showsMenuAsPrimaryAction = true
        
    }
    
    private func setCityLabel() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.leadingAnchor.constraint(equalTo: planeBtn.leadingAnchor).isActive = true
        cityLabel.topAnchor.constraint(equalTo: planeBtn.bottomAnchor, constant: 20).isActive = true
    
        cityLabel.text = defaults.string(forKey: "site")
        let font = UIFont.systemFont(ofSize: 25, weight: .bold)
        cityLabel.font = font
        cityLabel.textColor = .white
    }
    
    private func bindCollectionCardData() {
        
        let collectionView = cardListView.cardCollectionView
        
        sampleCards
            .bind(to: collectionView.rx.items(cellIdentifier: "PresentCardCell", cellType: CardCell.self)) { [self] row, model, cell in
            if (row == 0) {
                cell.setData("addPhoto")
                cell.removeBtn.isHidden = true
            } else {
                cell.setData(model)
                cell.removeBtn.addTarget(self, action: #selector(removeBtnClick(_:)), for: .touchUpInside)
                if self.longPressEnabled {
                    cell.startAnimate()
                } else {
                    cell.stopAnimate()
                }
            }
        }.disposed(by: disposeBag)

        collectionView.rx.setDelegate(cardListView).disposed(by: disposeBag)

        collectionView.rx.itemSelected.bind { indexPath in
            self.cardListView.cardCollectionView.deselectItem(at: indexPath, animated: true)
            
            if (indexPath.row == 0) {
                var config = YPImagePickerConfiguration()
                config.library.maxNumberOfItems = 5 - self.imageCount
                config.library.preSelectItemOnMultipleSelection = false
                config.library.defaultMultipleSelection = true
                config.library.mediaType = .photo
                config.library.isSquareByDefault = false
                config.onlySquareImagesFromCamera = false
                config.hidesCancelButton = false
                config.bottomMenuItemSelectedTextColour = UIColor(displayP3Red: 48/255, green: 113/255, blue: 231/255, alpha: 1.0)
                config.startOnScreen = .library
                config.wordings.libraryTitle = "모든 사진"
                config.wordings.albumsTitle = "앨범 목록"
                config.wordings.cameraTitle = "카메라"
                config.wordings.cover = "커버 사진"
                config.wordings.crop = "사진 크롭"
                config.wordings.filter = "필터 적용"
                config.wordings.save = "저장"
                config.wordings.ok = "확인"
                config.wordings.processing = "진행중"
                config.wordings.cancel = "취소"
                config.wordings.done = "완료"
                config.wordings.next = "다음"
                config.wordings.warningMaxItemsLimit = "최대 5장까지 첨부 가능합니다"
                
                let imagePicker = YPImagePicker(configuration: config)
                imagePicker.didFinishPicking{[unowned imagePicker] items, _ in
                    var newImages:[UIImage] = []
                    
                    for item in items {
                        switch item{
                        case .photo(let photo):
                            newImages += [photo.image]
                        case .video:
                            print("비디오는 아직 준비중이에요ㅜ")
                        }
                        
                    }
                    self.imageList = newImages
//                    MakeCardDescriptionViewController().photos = self.imageList
                    imagePicker.dismiss(animated: false)
                    let storyboard = UIStoryboard(name: "MakeCard", bundle: nil)
                    let makeCardVC = storyboard.instantiateViewController(withIdentifier: "MakeCard")
                    self.present(makeCardVC, animated: true)
                }
                imagePicker.view.backgroundColor = .white
                self.present(imagePicker, animated: true)
            } else {
                self.sendCardData(indexPath: indexPath)
            }
        }.disposed(by: disposeBag)
    }
    
    @IBAction func removeBtnClick(_ sender: UIButton) {
        let hitPoint = sender.convert(CGPoint.zero, to: self.cardListView.cardCollectionView)
        let hitIndex = self.cardListView.cardCollectionView.indexPathForItem(at: hitPoint)
        let row = hitIndex?.row ?? -1
        var original = self.sampleCards.value
        original.remove(at: row + 2)
        self.sampleCards.accept(original)
    }
    
    private func sendCardData(indexPath: IndexPath) {
//        viewModel.didSelect(indexPath)
        self.navigationController!.pushViewController(CardDetailViewController(), animated: true)
    }
}
