//
//  CardDetailViewController.swift
//  Yetda
//
//  Created by Jinsan Kim on 2022/07/19.
//

import UIKit

class CardDetailViewController: UIViewController, UIScrollViewDelegate {
    

//    let pageSize = Present().imageArray.count
    var dummyImages = ["Aichi", "Akita", "Aomori", "Chiba"]
    
    private var cardDetilView: CardDeatilView!
    private let keywords = Keywords()
    private let contents = "QWERTYQWERTYQWERTYQWEQRTYQWERTYQWERTYQWERTYQWERTYQWERTY"
    
    let pageSize = 4
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()

        pageControl.numberOfPages = pageSize
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.hidesForSinglePage = true
        
        return pageControl
    }()
    
    lazy var imageScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.view.frame)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.isPagingEnabled = true
        
        scrollView.delegate  = self
        
        scrollView.contentSize = CGSize(width: CGFloat(pageSize) * self.view.frame.maxX, height: 0)
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        registerCollectionView()
        collectionViewDelegate()
        
        let width = self.view.frame.maxX
        let height = self.view.frame.maxY
        
        let topContainerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height/2))
        topContainerView.backgroundColor = .systemBackground
        
        self.view.addSubview(topContainerView)
        
        pageControl.frame = CGRect(x: 0, y: topContainerView.frame.maxY - 50, width: topContainerView.frame.maxX, height: 50)
        
        for i in 0 ..< dummyImages.count {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * width, y: 0, width: width, height: topContainerView.frame.maxY))
            imageView.image = UIImage(named: dummyImages[i])
            imageView.contentMode = .scaleToFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 20
            imageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
            
            imageScrollView.addSubview(imageView)
        }
        
        self.view.addSubview(cardDetilView)
        cardDetilView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        cardDetilView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        cardDetilView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        cardDetilView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        topContainerView.addSubview(self.imageScrollView)
        topContainerView.addSubview(self.pageControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
    
    func configureCollectionView() {
        cardDetilView = CardDeatilView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cardDetilView.translatesAutoresizingMaskIntoConstraints = false
        cardDetilView.backgroundColor = .systemBackground
    }
    
    func registerCollectionView() {
        cardDetilView.register(KeywordCell.classForCoder(), forCellWithReuseIdentifier: "keywordCell")
        cardDetilView.register(ContentsCell.classForCoder(), forCellWithReuseIdentifier: "contentsCell")
        cardDetilView.register(MapCell.classForCoder(), forCellWithReuseIdentifier: "mapCell")
        cardDetilView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    
    func collectionViewDelegate() {
        cardDetilView.delegate = self
        cardDetilView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
}

extension CardDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 10
        let keywordWidth = collectionView.frame.width / 4 - 10
        
        switch (indexPath.section) {
        case 0:
            return CGSize(width: width, height: 50)
        case 1:
            return CGSize(width: width, height: 50)
        case 2:
            return CGSize(width: keywordWidth, height: keywordWidth)
        case 3:
            return CGSize(width: width, height: 300)
        case 4:
            return CGSize(width: width, height: 100)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return keywords.keywords.count
        case 3:
            return 1
        case 4:
            return 1
        default:
            return 0 
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value = 5.0
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let keywordCell = cardDetilView.dequeueReusableCell(withReuseIdentifier: "keywordCell", for: indexPath) as? KeywordCell
        let contentsCell = cardDetilView.dequeueReusableCell(withReuseIdentifier: "contentsCell", for: indexPath) as? ContentsCell
        let mapCell = cardDetilView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as? MapCell
        switch (indexPath.section) {
        case 0:
            contentsCell?.contentsLabel.text = "어딘가의 장소"
            contentsCell?.contentsLabel.backgroundColor = .lightGray
            contentsCell?.contentsLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
            return contentsCell ?? UICollectionViewCell()
        case 1:
            contentsCell?.contentsLabel.text = "대충 제목"
            contentsCell?.contentsLabel.backgroundColor = .lightGray
            return contentsCell ?? UICollectionViewCell()
        case 2:
            keywordCell?.keywordLabel.text = keywords.keywords[indexPath.row]
            keywordCell?.backgroundColor = .cyan
            return keywordCell ?? UICollectionViewCell()
        case 3:
            contentsCell?.contentsLabel.text = contents
            contentsCell?.backgroundColor = .lightGray
            return contentsCell ?? UICollectionViewCell()
        case 4:
            mapCell?.mapView
            return mapCell ?? UICollectionViewCell()
        default:
            contentsCell?.contentsLabel.text = contents
            contentsCell?.backgroundColor = .cyan
            return contentsCell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? HeaderView
        else { return UICollectionReusableView() }
        switch (indexPath.section) {
        case 3:
            header.backgroundColor = .red
            header.prepare(text: "함께 전하는 이야기")
            return header
        default:
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch (section) {
        case 3:
            return CGSize(width: collectionView.frame.width - 100, height: 30)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    
}
