//
//  SiteCell.swift
//  Yetda
//
//  Created by 김보승 on 2022/07/19.
//

import UIKit
import Hero

extension String {var localized: String {
    return NSLocalizedString(self, tableName: "LocalizingFile", value: self, comment: "")}
}

struct ImageName {
    var name: [String:String]
}

class SiteCell: UICollectionViewCell {
    
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var siteImage: UIImageView!
    @IBOutlet weak var siteShadowCell: UIImageView!
    @IBOutlet weak var sitePlaceIcon: UIImageView!
    
    func configure(_ data: Site) {
        
        self.isHeroEnabled = true
        self.hero.id = "\(data.name)".localized
        self.hero.modifiers = [.cascade]
        
        sitePlaceIcon.image = UIImage(named: "sitePlaceIcon")
        siteLabel.text = "\(data.name)".localized
        
        siteImage.widthAnchor.constraint(equalToConstant: 350).isActive = true
        siteImage.heightAnchor.constraint(equalToConstant: 141).isActive = true
 
        let firstUpper = data.name.first?.uppercased()
        let restString = String(data.name[data.name.index(after: data.name.startIndex)...])

        guard let first = firstUpper else { return }
        let imageName = first + restString
        
        siteImage.image = UIImage(named: SiteCell.imageList[data.name] ?? "\(imageName)")
        
        siteImage.contentMode = .scaleAspectFill
        siteImage.layer.cornerRadius = 20
        siteImage.clipsToBounds = true
        
        siteShadowCell.image = UIImage(named: "ShadowCell")
        siteShadowCell.contentMode = .scaleAspectFill
        siteShadowCell.layer.cornerRadius = 20
        siteShadowCell.clipsToBounds = true
    }
}

extension SiteCell {
    static let imageList = ["아이치" : "Aichi", "후쿠오카" : "Fukuoka", "아키타" : "Akita", "아오모리" : "Aomori", "치바" : "Chiba", "에히메" : "Ehime", "후쿠이" : "Fukui", "후쿠시마" : "Fukushima", "기후" : "Gifu", "군마" : "Gunma", "히로시마" : "Hiroshima", "홋카이도" : "Hokkaido", "효고" : "Hyogo", "이바라키" : "Ibaraki" ,
                            "이시카와" : "Ishikawa",
                            "이와테" : "Iwate" ,
                            "가가와" : "Kagawa",
                            "가고시마" : "Kagoshima",
                            "가나가와" : "Kanagawa",
                            "고치" : "Kochi",
                            "구마모토" : "Kumamoto",
                            "교토" : "Kyoto",
                            "미에" : "Mie",
                            "미야기" : "Miyagi",
                            "미야자키" : "Miyazaki",
                            "나가노" : "Nagano",
                            "나가사키" : "Nagasaki",
                            "나라" : "Nara",
                            "니이가타" : "Niigata",
                            "오이타" : "Oita",
                            "오카야마" : "Okayama",
                            "오키나와" : "Okinawa",
                            "오사카" : "Osaka",
                            "사가" : "Saga",
                            "사이타마" : "Saitama",
                            "시가" : "Shiga",
                            "시마네" : "Shimane",
                            "시즈오카" : "Shizuoka",
                            "도치기" : "Tochigi",
                            "도쿠시마" : "Tokushima",
                            "도쿄" : "Tokyo",
                            "돗토리" : "Tottori",
                            "도야마" : "Toyama",
                            "와카야마" : "Wakayama",
                            "야마가타" : "Yamagata",
                            "야마구치" : "Yamaguchi",
                            "야마나시" : "Yamanashi", ]
}
