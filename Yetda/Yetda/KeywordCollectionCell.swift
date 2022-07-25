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
    
    @IBOutlet weak var keywordButton: UIButton!
    @IBAction func keywordButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        bindState(sender.titleLabel?.text ?? "", sender.isSelected)
        changeButtonState(sender)
    }
    
    private func bindState(_ name: String, _ select: Bool) {
        if select && count<4 {
            appDelegate?.selectedKeyword.append(name)
            for keyword in MakeCardDescriptionViewController().keywords {
                if (keyword.findKeyword(name: name)) {
                    keyword.state = true
                    count += 1
                }
            }
        }
        else {
            if let index = appDelegate?.selectedKeyword.firstIndex(of: name) {
                appDelegate?.selectedKeyword.remove(at: index)
                for keyword in MakeCardDescriptionViewController().keywords {
                    if (keyword.findKeyword(name: name)) {
                        keyword.state = false
                        MakeCardDescriptionViewController().count -= 1
                    }
                }
            }
        }
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
