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
    @IBOutlet var siteMenu: UIMenu!
    
    let disposeBag = DisposeBag()
    
    let list = [SiteModel(name: "Fukuoka"), SiteModel(name: "Akita"), SiteModel(name: "Fukushima"), SiteModel(name: "Tokyo"), SiteModel(name: "Nagasaki")]
    
    typealias Item = SiteModel
    enum Section {
        case main
    }
    var siteDataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        siteCollectionView.layer.cornerRadius = 20
        
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
    
//        self.isHeroEnabled = true
//        self.siteCollectionView.hero.id = "site"
        self.hero.modalAnimationType = .fade
        bindTouch()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let UICClayoutInsetSize: CGFloat = UIScreen.main.bounds.width - 30
        let spacingSize: CGFloat = 15
        
        let itemsize = NSCollectionLayoutSize(widthDimension: .absolute(UICClayoutInsetSize), heightDimension: .estimated(100))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemsize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout])
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15)
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

