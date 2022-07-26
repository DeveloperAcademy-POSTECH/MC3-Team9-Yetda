//
//  KeywordCollectionCell.swift
//  Yetda
//
//  Created by Youngseo Yoon on 2022/07/19.
//

import UIKit

class KeywordCollectionCell: UICollectionViewCell {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var count = 0
    var testKeyword: Keyword!
    
    @IBOutlet weak var keywordButton: UIButton!
    
    // index값을 사용하지 않을 때는 굳이 인자에 넣어가며 할 필요가 없음
    func initButton() {
        keywordButton.translatesAutoresizingMaskIntoConstraints = false
        keywordButton.widthAnchor.constraint(greaterThanOrEqualTo: keywordButton.titleLabel?.widthAnchor ?? keywordButton.widthAnchor, constant: 20).isActive = true
        
        keywordButton.layer.cornerRadius = 19.0
        keywordButton.layer.masksToBounds = true
        keywordButton.backgroundColor = UIColor.white
        keywordButton.layer.borderColor = CGColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        keywordButton.layer.borderWidth = 1.0
    }
    
    func setButton(_ isSelected: Bool) {
        keywordButton.backgroundColor = isSelected ? UIColor(red: 211/255, green: 226/255, blue: 253/255, alpha: 0.1) : UIColor.white
        keywordButton.layer.borderColor = isSelected ? CGColor(red: 48/255, green: 113/255, blue: 231/255, alpha: 0.5) : CGColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
    }
    
    // 버튼 커스터마이징 하는 함수
    func customButton(_ button: UIButton) {
        button.layer.cornerRadius = 19.0
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.white
        button.layer.borderColor = CGColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        button.layer.borderWidth = 1.0
    }

}

