//
//  ContentsCell.swift
//  Yetda
//
//  Created by Jinsan Kim on 2022/07/21.
//

import UIKit

class ContentsCell: UICollectionViewCell {
    var contentsLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        setupLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
        setupLabel()
    }
    
    func setupCell() {
        contentsLabel = UILabel()
        contentView.addSubview(contentsLabel)
        contentsLabel.clipsToBounds = true
        contentsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        contentsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        contentsLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentsLabel.layer.cornerRadius = 12
    }
    
    func setupLabel() {
        contentsLabel.numberOfLines = 0
        contentsLabel.font = UIFont.systemFont(ofSize: 14)
        contentsLabel.textAlignment = .natural
    }
}
