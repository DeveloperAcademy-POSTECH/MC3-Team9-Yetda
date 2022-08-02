//
//  CardDetailViewController.swift
//  Yetda
//
//  Created by Jinsan Kim on 2022/07/19.
//

import UIKit

class CardDetailViewController: UIViewController, UIScrollViewDelegate, ShareKaKao {
    

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
    
    lazy var topContainerView: UIView = {
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        let topContainerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth))
        
        topContainerView.backgroundColor = UIColor(named: "YettdaMainBackground")
        topContainerView.clipsToBounds = true
        topContainerView.layer.cornerRadius = 20
        topContainerView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        return topContainerView
    }()
    
    lazy var cardDetailView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cardDetailView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cardDetailView.delegate = self
        cardDetailView.dataSource = self
        
        cardDetailView.backgroundColor = UIColor(named: "YettdaMainBackground")
        cardDetailView.register(KeywordCell.self, forCellWithReuseIdentifier: "keywordCell")
        cardDetailView.register(ContentsCell.self, forCellWithReuseIdentifier: "contentsCell")
        cardDetailView.register(MapCell.self, forCellWithReuseIdentifier: "mapCell")
        cardDetailView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        return cardDetailView
    }()
    
    lazy var backButton: UIButton = {
        let button = makeButton(symbols: "chevron.backward")
        button.addTarget(self, action: #selector(moveToHomeView), for: .touchUpInside)
        
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = makeButton(symbols: "square.and.arrow.up")
//        button.addTarget(self, action: #selector(popoverModal), for: .touchUpInside)
        
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "YettdaMainBackground")
        
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        
        self.view.addSubview(topContainerView)
        setTopContainerViewConstraints(width: screenWidth, height: screenHeight)
        
        for i in 0 ..< dummyImages.count {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * screenWidth, y: 0, width: screenWidth, height: topContainerView.frame.height))
            imageView.image = UIImage(named: dummyImages[i])
            imageView.contentMode = .scaleToFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 20
            imageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
            
            imageScrollView.addSubview(imageView)
        }
        
        self.view.addSubview(cardDetailView)
        topContainerView.addSubview(imageScrollView)
        topContainerView.addSubview(pageControl)
        topContainerView.addSubview(backButton)
        
        setCardDetailViewConstraints(topView: topContainerView)
        setPageControlConstraints(topView: topContainerView)
        setBackButtonConstraints(topView: topContainerView, width: screenWidth)
        setShareButtonConstraints(topView: topContainerView, width: screenWidth)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
    
    func makeButton(symbols: String) -> UIButton {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: symbols)?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 22, weight: .regular), forImageIn: .normal)
        button.configuration = .filled()
        button.tintColor = .white
        button.configuration?.imagePadding = 0
        button.alpha = 0.8
        
        return button
    }
    
    func setTopContainerViewConstraints(width: CGFloat, height: CGFloat) {
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -width).isActive = true
    }
    
    func setBackButtonConstraints(topView: UIView, width: CGFloat) {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        backButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -(width-60)).isActive = true
    }
    
    func setShareButtonConstraints(topView: UIView, width: CGFloat) {
        let configureShareButton = configureShareButton(self, action: #selector(shareButtonAction))

        configureShareButton.translatesAutoresizingMaskIntoConstraints = false
        configureShareButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20).isActive = true
        configureShareButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: width-60).isActive = true
        configureShareButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20).isActive = true
    }
    
    func setCardDetailViewConstraints(topView: UIView) {
        cardDetailView.translatesAutoresizingMaskIntoConstraints = false
        cardDetailView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        cardDetailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cardDetailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        cardDetailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setPageControlConstraints(topView: UIView) {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -50).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
    }
    
    @objc func moveToHomeView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func popOverModal() {
//        var vc = UIViewController()
//        self.present(vc, animated: true)
    }
    
    @objc func shareButtonAction(sender: UIButton!) {
        shareKaKao(self, key: "Id", value: "2") {
            let storyboard = UIStoryboard(name: "DidPresent", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DidPresentViewController")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}

extension CardDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    enum Section: Int {
        case site
        case title
        case keywordsCell
        case story
        case map
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 10
        let keywordWidth = collectionView.frame.width / 4 - 10
        
        let cellSize = NSString(string: contents).boundingRect(
            with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)],
            context: nil
        )
        
        switch (indexPath.section) {
        case Section.site.rawValue:
            return CGSize(width: width, height: 50)
        case Section.title.rawValue:
            return CGSize(width: width, height: 50)
        case Section.keywordsCell.rawValue:
            return CGSize(width: keywordWidth, height: keywordWidth)
        case Section.story.rawValue:
            return CGSize(width: width, height: cellSize.height + 20)
        case Section.map.rawValue:
            return CGSize(width: width, height: 100)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (section) {
        case Section.site.rawValue:
            return 1
        case Section.title.rawValue:
            return 1
        case Section.keywordsCell.rawValue:
            return keywords.keywords.count
        case Section.story.rawValue:
            return 1
        case Section.map.rawValue:
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
        
        switch (indexPath.section) {
        case Section.site.rawValue:
            contentsCell?.contentsLabel.text = "어딘가의 장소"
            return contentsCell ?? UICollectionViewCell()
        case Section.title.rawValue:
            contentsCell?.contentsLabel.text = "대충 제목"
            contentsCell?.contentsLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            contentsCell?.backgroundColor = UIColor(named: "YettdaBackgroundcolor")
            return contentsCell ?? UICollectionViewCell()
        case Section.keywordsCell.rawValue:
            keywordCell?.keywordLabel.text = keywords.keywords[indexPath.row]
            keywordCell?.backgroundColor = .cyan
            return keywordCell ?? UICollectionViewCell()
        case Section.story.rawValue:
            contentsCell?.contentsLabel.text = contents
            return contentsCell ?? UICollectionViewCell()
        case Section.map.rawValue:
            mapCell?.moveLocation(latitudeValue: 37.334754657382234, longitudeValue: -122.00898272593827, delta: 0.01)
            mapCell?.setAnnotation(latitudeValue: 37.334754657382234, longitudeValue: -122.00898272593827, delta: 0.01, title: "Apple Park", subtitle: "aa")
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
        case Section.story.rawValue:
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
            return CGSize(width: collectionView.frame.width, height: 30)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
}
