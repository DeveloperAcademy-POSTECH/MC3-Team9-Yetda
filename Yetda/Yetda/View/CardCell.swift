//
//  CardView.swift
//  Yetda
//
//  Created by 이채민 on 2022/07/18.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CardCell: UICollectionViewCell {
    
    static let identifier = "PresentCardCell"

    var nameLabel: UILabel = UILabel()
    var firstImage: UIImage?
    var thumbnailImage: UIImageView = UIImageView()
    let disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        thumbnailImage.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupCell() {
        self.contentView.layer.cornerRadius = 20
        self.contentView.clipsToBounds = true
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        self.contentView.addSubview(thumbnailImage)
        setThumbnailImage()
        self.contentView.addSubview(nameLabel)
        setNameLabel()
    }
    
    private func setThumbnailImage() {
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        thumbnailImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        thumbnailImage.clipsToBounds = true
        thumbnailImage.layer.cornerRadius = 20
        thumbnailImage.contentMode = .scaleAspectFill
    }
    
    private func setNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameLabel.font = font
        nameLabel.textColor = .blue
        nameLabel.backgroundColor = .white
        nameLabel.layer.cornerRadius = 10
        nameLabel.clipsToBounds = true
    }
    
    func setData(_ model: String) {
        if (model == "addPhoto") {
            self.contentView.backgroundColor = .white
            thumbnailImage.image = UIImage(named: "plus")
        } else {
            self.nameLabel.text = "  To. " + String(model.split(separator: ".")[0]) + "  "
            thumbnailImage.image = UIImage(named: model)
        }
    }
}
