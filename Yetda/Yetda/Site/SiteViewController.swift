//
//  SiteViewController.swift
//  Yetda
//
//  Created by 김보승 on 2022/07/19.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import Hero

class SiteViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var siteViewAirplaneIcon: UIImageView!
    @IBOutlet weak var siteTitleLabel: UILabel!
    @IBOutlet weak var siteViewButton: UIButton!
    @IBOutlet weak var siteCollectionView: UICollectionView!
    @IBOutlet var siteView: UIView!
    
    let disposeBag = DisposeBag()
    
    let list = [SiteModel(name: "Fukuoka"), SiteModel(name: "Akita"), SiteModel(name: "Fukushima"), SiteModel(name: "Tokyo"), SiteModel(name: "Nagasaki")]
    
    typealias Item = SiteModel
    enum Section {
        case main
    }
    var siteDataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makeSiteSearchBar()
        
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
    
        self.hero.modalAnimationType = .fade
        bindTouch()
    }
    func makeSiteSearchBar() {
        
        let siteSearchBar = UISearchBar()
        siteSearchBar.placeholder = "여행지를 추가해주세요"
        siteSearchBar.searchBarStyle = .minimal
        siteSearchBar.backgroundColor = UIColor(named: "YettdaMainBackground")
        siteSearchBar.sizeToFit()
        siteSearchBar.frame.size.width = siteCollectionView.frame.size.width
        siteSearchBar.layer.cornerRadius = 30
        siteSearchBar.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        siteView.addSubview(siteSearchBar)
        
        siteSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        siteSearchBar.topAnchor.constraint(equalTo: siteView.topAnchor, constant: 180).isActive = true
        siteSearchBar.widthAnchor.constraint(equalToConstant: siteCollectionView.frame.size.width).isActive = true
        siteSearchBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let directionalMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: -20, trailing: 20)
        siteSearchBar.directionalLayoutMargins = directionalMargins
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let UICClayoutInsetSize: CGFloat = UIScreen.main.bounds.width - 40
        let spacingSize: CGFloat = 20
        
        let itemsize = NSCollectionLayoutSize(widthDimension: .absolute(UICClayoutInsetSize), heightDimension: .estimated(100))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemsize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout])
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 53, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = spacingSize
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func bindTouch() {
        siteCollectionView.rx.itemSelected.bind { indexPath in
            self.siteCollectionView.deselectItem(at: indexPath, animated: true)
            let vc = HomeViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}

