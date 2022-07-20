//
//  KeywordCollectionCell.swift
//  Yetda
//
//  Created by Youngseo Yoon on 2022/07/19.
//

import UIKit

class KeywordCollectionCell: UICollectionViewCell {
    
    var count: Int = 0
    var selectedKeyword: [String] = []
    
    @IBOutlet weak var keywordButton: UIButton!
    @IBAction func keywordButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            selectedKeyword.append("\(sender.titleLabel?.text ?? "")")
        }
        else {
            if let index = selectedKeyword.firstIndex(of: sender.titleLabel?.text ?? "") {
                selectedKeyword.remove(at: index)
            }
        }
        print(selectedKeyword)
        changeButtonState(sender)
    }
    
    func customizeButton(_ index: IndexPath) {
        keywordButton.translatesAutoresizingMaskIntoConstraints = false
        keywordButton.widthAnchor.constraint(greaterThanOrEqualTo: keywordButton.titleLabel?.widthAnchor ?? keywordButton.widthAnchor, constant: 20).isActive = true
        customButton(keywordButton)
    }
    
    func changeButtonState(_ button : UIButton) {
        button.backgroundColor = button.isSelected ? UIColor.systemCyan : UIColor.white
        button.layer.borderColor = button.isSelected ? CGColor(red: 211, green: 226, blue: 253, alpha: 1) : CGColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
    }
}

// 버튼 커스터마이징 하는 함수
func customButton(_ button: UIButton) {
    button.layer.cornerRadius = 19.0
    button.layer.masksToBounds = true
    button.backgroundColor = UIColor.white
    button.layer.borderColor = CGColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
    button.layer.borderWidth = 1.0    
}
