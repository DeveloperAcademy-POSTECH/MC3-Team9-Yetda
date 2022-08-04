//
//  HeaderView.swift
//  Yetda
//
//  Created by Jinsan Kim on 2022/07/22.
//

import UIKit

class HeaderView: UICollectionReusableView {
    private lazy var label: UILabel = {
        let label = UILabel()
        
        self.addSubview(label)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.backgroundColor = UIColor(named: "YettdaMainBackground")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: nil)
    }
    
    func prepare(text: String?) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "envelope.open")?.withTintColor(.systemBlue)
        let attachmentString = NSAttributedString(attachment: attachment)
        guard let text = text else { return }
        let contentString = NSMutableAttributedString(string: " \(String(describing: text))")
        contentString.insert(attachmentString, at: 0)
        self.label.attributedText = contentString
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 14)
    }
}
