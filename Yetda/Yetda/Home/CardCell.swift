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
    var thumbnailImage: UIImageView = UIImageView()
    
    var removeBtn = UIButton(configuration: UIButton.Configuration.plain())
    
    var isAnimate = false
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
//        self.contentView.clipsToBounds = true
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
        self.addSubview(removeBtn)
        setRemoveBtn()
    }
    
    private func setThumbnailImage() {
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        thumbnailImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
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
    
    private func setRemoveBtn() {
        removeBtn.translatesAutoresizingMaskIntoConstraints = false
        removeBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        removeBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: -15).isActive = true
        
        removeBtn.configuration?.image = UIImage(systemName: "x.circle.fill")
        removeBtn.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .large)
        removeBtn.configuration?.baseForegroundColor = .lightGray
        
        removeBtn.isHidden = true
    }
    
    func setData(image: String, whosFor: String) {
        if (image == "addPhoto") {
            self.contentView.backgroundColor = .white
            thumbnailImage.image = UIImage(named: "plus")
        } else {
            self.nameLabel.text = "  To. " + whosFor + "  "
            StorageManager.downloadImage(urlString: image, completion: setImage)
            func setImage(image: UIImage?) -> Void {
                thumbnailImage.image = image ?? UIImage(named: "photo4")!
            }
        }
    }
    
    func startAnimate() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 4
        shakeAnimation.autoreverses = true
        shakeAnimation.duration = 0.2
        shakeAnimation.repeatCount = 99999
        
        let startAngle: Float = (-1) * 3.14159/180
        let stopAngle: Float = -startAngle
        
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.autoreverses = true
        shakeAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = self.layer
        layer.add(shakeAnimation, forKey: "animate")
        removeBtn.isHidden = false
        isAnimate = true
    }
    
    func stopAnimate() {
        let layer: CALayer = self.layer
        layer.removeAnimation(forKey: "animate")
        removeBtn.isHidden = true
        isAnimate = false
    }
}
