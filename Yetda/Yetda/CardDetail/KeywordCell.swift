//
//  CardDetailViewKeywordCell.swift
//  Yetda
//
//  Created by Jinsan Kim on 2022/07/20.
//

import UIKit

class KeywordCell: UICollectionViewCell {
    
    var keywordLabel: UILabel!
    
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
        keywordLabel = UILabel()
        contentView.addSubview(keywordLabel)
        keywordLabel.clipsToBounds = true
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        keywordLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        keywordLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        keywordLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        keywordLabel.layer.cornerRadius = 12
    }
    
    func setupLabel() {
        keywordLabel.font = UIFont.systemFont(ofSize: 14)
        keywordLabel.textAlignment = .center
    }
}
