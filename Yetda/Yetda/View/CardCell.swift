//
//  CardView.swift
//  Yetda
//
//  Created by 이채민 on 2022/07/18.
//

import Foundation
import UIKit

class CardCell: UICollectionViewCell {
    
    static let identifier = "PresentCardCell"

    var nameLabel: UILabel = UILabel()
    var thumbnailImage: UIImageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        thumbnailImage.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupCell() {
        // TODO: 가로, 세로 길이 설정
        
        self.contentView.addSubview(thumbnailImage)
        setThumbnailImage()
        self.contentView.addSubview(nameLabel)
        setNameLabel()
        
    }
    
    func loadImage() {
        // TODO: 이미지 가져오기
    }
    
    private func setThumbnailImage() {
        
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        thumbnailImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        thumbnailImage.trailingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        thumbnailImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        thumbnailImage.clipsToBounds = true
        thumbnailImage.layer.cornerRadius = 20
        thumbnailImage.contentMode = .scaleAspectFill
        
    }
    
    private func setNameLabel() {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
    }
    
}
