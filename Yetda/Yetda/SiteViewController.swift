//
//  SiteViewController.swift
//  Yetda
//
//  Created by 김보승 on 2022/07/19.
//

import UIKit

class SiteViewController: UIViewController, UICollectionViewDelegate {
    
    
    @IBOutlet weak var siteViewAirplaneIcon: UIImageView!
    @IBOutlet weak var siteTitleLabel: UILabel!
    @IBOutlet weak var siteViewButton: UIButton!
    @IBOutlet weak var siteCollectionView: UICollectionView!
    @IBOutlet var siteMenu: UIMenu!
    @IBOutlet var siteView: UIView!
    
    let list = [SiteModel(name: "Fukuoka"), SiteModel(name: "Akita"), SiteModel(name: "Fukushima"), SiteModel(name: "Tokyo"), SiteModel(name: "Nagasaki")] //TODO: 임시데이터 상수값이기 때문에 데이터 연결 후 삭제해랴 합니다.
    
    typealias Item = SiteModel
    enum Section {
        case main
    }
    var siteDataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        siteCollectionView.layer.cornerRadius = 20
        
        self.makeSiteSearchBar()
        
        lazy var menuChildren: [UIAction] = {
            return [
                UIAction(title: "목록 편집", image: UIImage(systemName: "pencil"), state: .off, handler: { _ in }), //TODO: 편집기능 넣기
                UIAction(title: "닫기", image: UIImage(systemName: "arrow.down.forward.and.arrow.up.backward.circle"), state: .off, handler: { _ in })
            ]
        }()
        
        siteViewButton.menu =  UIMenu(title: "", image: UIImage(systemName: "pencil"), identifier: nil, options: .displayInline, children: menuChildren)
        siteCollectionView.collectionViewLayout = layout()
        siteCollectionView.delegate = self
        
        siteDataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: siteCollectionView, cellProvider: {
            collectionView, indexPath, item in
            guard let siteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCell", for: indexPath)
                    as? SiteCell else {
                return nil
            }
            siteCell.configure(item)
            return siteCell})
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        siteDataSource.apply(snapshot)
    }
    
    func makeSiteSearchBar() {
        
        let siteSearchBar = UISearchBar()
        siteSearchBar.placeholder = "여행지를 추가해주세요"
        siteSearchBar.searchBarStyle = .minimal
        siteSearchBar.backgroundColor = .systemBackground
        siteSearchBar.sizeToFit()
        siteSearchBar.frame.size.width = siteCollectionView.frame.size.width
        siteSearchBar.layer.cornerRadius = 20
        siteSearchBar.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        siteView.addSubview(siteSearchBar)
        
        siteSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        siteSearchBar.topAnchor.constraint(equalTo: siteView.topAnchor, constant: 189).isActive = true
        siteSearchBar.widthAnchor.constraint(equalToConstant: siteCollectionView.frame.size.width).isActive = true
        siteSearchBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let directionalMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        siteSearchBar.directionalLayoutMargins = directionalMargins
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let UICClayoutInsetSize: CGFloat = UIScreen.main.bounds.width - 24
        let spacingSize: CGFloat = 16
        
        let itemsize = NSCollectionLayoutSize(widthDimension: .absolute(UICClayoutInsetSize), heightDimension: .estimated(100))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemsize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout])
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 12, bottom: 0, trailing: 12)
        section.interGroupSpacing = spacingSize
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}


