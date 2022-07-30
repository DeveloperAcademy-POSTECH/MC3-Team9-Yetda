//
//  KeywordCollectionCell.swift
//  Yetda
//
//  Created by Youngseo Yoon on 2022/07/19.
//

import UIKit

class KeywordCollectionCell: UICollectionViewCell {
        
    @IBOutlet weak var keywordButton: UIButton!
    
    func initButton() {
        keywordButton.translatesAutoresizingMaskIntoConstraints = false
        keywordButton.widthAnchor.constraint(greaterThanOrEqualTo: keywordButton.titleLabel?.widthAnchor ?? keywordButton.widthAnchor, constant: 20).isActive = true
        
        keywordButton.layer.cornerRadius = 19.0
        keywordButton.layer.masksToBounds = true
        keywordButton.backgroundColor = UIColor.white
        keywordButton.layer.borderColor = UIColor(named: "YettdaMainGray")?.cgColor
        keywordButton.layer.borderWidth = 1.0
    }
    
    func setButton(_ isSelected: Bool) {
        keywordButton.backgroundColor = isSelected ? UIColor(red: 211/255, green: 226/255, blue: 253/255, alpha: 0.1) : UIColor.white
        keywordButton.layer.borderColor = isSelected ? CGColor(red: 48/255, green: 113/255, blue: 231/255, alpha: 0.5) : UIColor(named: "YettdaMainGray")?.cgColor
    }
}

