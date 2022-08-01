//
//  SiteCell.swift
//  Yetda
//
//  Created by 김보승 on 2022/07/19.
//

import UIKit
import Hero

extension String {var localized: String {
    return NSLocalizedString(self, tableName: "LocalizingFile", value: self, comment: "")}
}

class SiteCell: UICollectionViewCell {
    
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var siteImage: UIImageView!
    @IBOutlet weak var siteShadowCell: UIImageView!
    @IBOutlet weak var sitePlaceIcon: UIImageView!
    
    func configure(_ data: String) {
        
        self.isHeroEnabled = true
        self.hero.id = "\(data)".localized
        self.hero.modifiers = [.cascade]
        
        sitePlaceIcon.image = UIImage(named: "sitePlaceIcon")
        siteLabel.text = "\(data)".localized
        
        siteImage.widthAnchor.constraint(equalToConstant: 350).isActive = true
        siteImage.heightAnchor.constraint(equalToConstant: 141).isActive = true

        siteImage.image = UIImage(named: "\(data)")
        siteImage.contentMode = .scaleAspectFill
        siteImage.layer.cornerRadius = 20
        siteImage.clipsToBounds = true
        
        siteShadowCell.image = UIImage(named: "ShadowCell")
        siteShadowCell.contentMode = .scaleAspectFill
        siteShadowCell.layer.cornerRadius = 20
        siteShadowCell.clipsToBounds = true
    }
}
