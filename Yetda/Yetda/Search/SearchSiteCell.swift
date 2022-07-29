//
//  SearchSiteCell.swift
//  Yetda
//
//  Created by rbwo on 2022/07/25.
//

import UIKit

class SearchSiteCell: UICollectionViewCell {
    let nameLabel = UILabel()
    static let reuseIdentifier: String = "SearchResultCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configure(_ data: String) {
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        nameLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 17)
        nameLabel.textAlignment = .left
        nameLabel.text = data.localized
    }
}
