//
//  SiteViewController.swift
//  Yetda
//
//  Created by 김보승 on 2022/07/19.
//

import UIKit
import SwiftUI

class SiteViewController: UIViewController, UICollectionViewDelegate {

    //@IBOutlet weak var siteViewBackground: UIImageView!
    //@IBOutlet weak var siteCollectionCell: UICollectionViewCell!
    //@IBOutlet weak var siteShadowCell: UIImageView!
    @IBOutlet weak var siteCollectionView: UICollectionView!
    
    let list = [SiteModel(name: "Fukuoka"), SiteModel(name: "Akita"), SiteModel(name: "Fukushima"), SiteModel(name: "Tokyo"), SiteModel(name: "Nagasaki")]
    
    typealias Item = SiteModel
    enum Section {
        case main
    }
    var siteDataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        siteViewBackground.image = UIImage(named: "BackgroundDesign")
//        siteShadowCell.image = UIImage(named: "ShadowCell")
//
        
        siteCollectionView.collectionViewLayout = layout()
        siteCollectionView.delegate = self
        
        siteDataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: siteCollectionView, cellProvider: {
            collectionView, indexPath, item in
            guard let siteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCell", for: indexPath)
                    as? SiteCell else {
                return nil
            }
            siteCell.configure(item)
            return siteCell
            
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        siteDataSource.apply(snapshot)
        
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        
        let spacingSize: CGFloat = 16
        
        let itemsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemsize)
//        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32)
        print(itemsize.widthDimension.dimension.significandWidth)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout]
        )
        //groupLayout.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 32, bottom: 0, trailing: spacingSize)
        
//        groupLayout.interItemSpacing = .fixed(spacingSize)
        
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 12, bottom: 0, trailing: 12)
        
        section.interGroupSpacing = spacingSize
        
        
        return UICollectionViewCompositionalLayout(section: section)
        }
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            return     UINavigationController(rootViewController: SiteViewController())
//        }
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        }
//        typealias  UIViewControllerType = UIViewController
//    }
//}

