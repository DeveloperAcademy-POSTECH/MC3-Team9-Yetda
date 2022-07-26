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
    
    private let keywords = Keywords()
    private let contents = "QWERTYQWERTYQWERTYQWEQRTYQWERTYQWERTYQWERTYQWERTYQWERTYQWERTYQWERTYQWERTYQWEQRTYQWERTYQWERTYQWERTYQWERTYQWERTY"
    
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
    
    lazy var cardDetailView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cardDetailView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cardDetailView.delegate = self
        cardDetailView.dataSource = self
        
        cardDetailView.translatesAutoresizingMaskIntoConstraints = false
        cardDetailView.backgroundColor = .systemBackground
        cardDetailView.register(KeywordCell.self, forCellWithReuseIdentifier: "keywordCell")
        cardDetailView.register(ContentsCell.self, forCellWithReuseIdentifier: "contentsCell")
        cardDetailView.register(MapCell.self, forCellWithReuseIdentifier: "mapCell")
        cardDetailView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        return cardDetailView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        view.addSubview(cardDetailView)
        cardDetailView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        cardDetailView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        cardDetailView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        cardDetailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
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
}

extension CardDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let site: Int = 0
        let title: Int = 1
        let keywordsCell: Int = 2
        let description: Int = 3
        let map: Int = 4
        
        let width = collectionView.frame.width - 10
        let keywordWidth = collectionView.frame.width / 4 - 10
        
        let cellSize = NSString(string: contents).boundingRect(
            with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)],
            context: nil
        )
        
        switch (indexPath.section) {
        case site:
            return CGSize(width: width, height: 50)
        case title:
            return CGSize(width: width, height: 50)
        case keywordsCell:
            return CGSize(width: keywordWidth, height: keywordWidth)
        case description:
            return CGSize(width: width, height: cellSize.height + 20)
        case map:
            return CGSize(width: width, height: 100)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let site: Int = 0
        let title: Int = 1
        let keywordsCell: Int = 2
        let description: Int = 3
        let map: Int = 4
        
        switch (section) {
        case site:
            return 1
        case title:
            return 1
        case keywordsCell:
            return keywords.keywords.count
        case description:
            return 1
        case map:
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
        let keywordCell = cardDetailView.dequeueReusableCell(withReuseIdentifier: "keywordCell", for: indexPath) as? KeywordCell
        let contentsCell = cardDetailView.dequeueReusableCell(withReuseIdentifier: "contentsCell", for: indexPath) as? ContentsCell
        let mapCell = cardDetailView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as? MapCell
        
        let site: Int = 0
        let title: Int = 1
        let keywordsCell: Int = 2
        let description: Int = 3
        let map: Int = 4
        
        switch (indexPath.section) {
        case site:
            contentsCell?.contentsLabel.text = "어딘가의 장소"
            contentsCell?.contentsLabel.backgroundColor = .lightGray
            return contentsCell ?? UICollectionViewCell()
        case title:
            contentsCell?.contentsLabel.text = "대충 제목"
            contentsCell?.contentsLabel.backgroundColor = .lightGray
            return contentsCell ?? UICollectionViewCell()
        case keywordsCell:
            keywordCell?.keywordLabel.text = keywords.keywords[indexPath.row]
            keywordCell?.backgroundColor = .cyan
            keywordCell?.layer.cornerRadius = 12
            return keywordCell ?? UICollectionViewCell()
        case description:
            contentsCell?.contentsLabel.text = contents
            contentsCell?.backgroundColor = .lightGray
            contentsCell?.layer.cornerRadius = 12
            return contentsCell ?? UICollectionViewCell()
        case map:
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
        let description: Int = 3
        
        switch (indexPath.section) {
        case description:
            header.backgroundColor = .red
            header.prepare(text: "함께 전하는 이야기")
            return header
        default:
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let description: Int = 3
        
        switch (section) {
        case description:
            return CGSize(width: collectionView.frame.width - 100, height: 30)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
}
