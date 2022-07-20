//
//  SiteCell.swift
//  Yetda
//
//  Created by 김보승 on 2022/07/19.
//

import UIKit

class SiteCell: UICollectionViewCell {
    
   // let list = ["Fukuoka", "Fukushima"]
    
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var siteImage: UIImageView!
    @IBOutlet weak var siteShadowCell: UIImageView!
    
    func configure(_ data: SiteModel) {
        siteLabel.text = "\(data.name)"
        
        siteImage.widthAnchor.constraint(equalToConstant: 350).isActive = true
        siteImage.heightAnchor.constraint(equalToConstant: 141).isActive = true
//        siteImage.backgroundColor = UIColor(patternImage: UIImage(named: "\(data.name)")!)
        siteImage.image = UIImage(named: "\(data.name)")
        siteImage.contentMode = .scaleAspectFill
        siteImage.layer.cornerRadius = 20
        siteImage.clipsToBounds = true
        
        
        
        siteShadowCell.image = UIImage(named: "ShadowCell")
        siteShadowCell.contentMode = .scaleAspectFill
        siteShadowCell.layer.cornerRadius = 20
        siteShadowCell.clipsToBounds = true
        
        
    }
}
