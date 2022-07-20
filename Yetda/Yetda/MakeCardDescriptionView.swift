//
//  MakeCardDescriptionView.swift
//  Yetda
//
//  Created by Youngseo Yoon on 2022/07/18.
//

import UIKit

class MakeCardDescriptionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var giftNameTextField: UITextField!
    @IBOutlet weak var giftRecipientTextField: UITextField!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var keywordCollection: UICollectionView!
    @IBOutlet weak var backGroundView: UIView!
    
    var photos: [String] = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    var keywords: [Keyword] = [
        Keyword(name: "☀️햇빛쨍쨍", state: false),
        Keyword(name: "😋짱맛있대", state: false),
        Keyword(name: "🤑플렉스~", state: false),
        Keyword(name: "🧳짐이많아", state: false),
        Keyword(name: "❄️눈이내려", state: false),
        Keyword(name: "👍추천받음", state: false),
        Keyword(name: "⭐️별다섯개", state: false),
        Keyword(name: "☔️비가내려", state: false),
        Keyword(name: "🥶너무추워", state: false),
        Keyword(name: "🥰생각나서", state: false),
        Keyword(name: "🫵완전너꺼", state: false),
        Keyword(name: "🛍양손가득", state: false),
        Keyword(name: "🥵너무더워", state: false),
        Keyword(name: "🥳축하해~", state: false),
        Keyword(name: "🤫비밀선물", state: false),
        Keyword(name: "🍯완전달달", state: false),
        Keyword(name: "💸비싼거야", state: false),
        Keyword(name: "🗽관광중~", state: false),
        Keyword(name: "🏝휴양중~", state: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        borderRadius(view: giftNameTextField).addLeftPadding()
        borderRadius(view: giftRecipientTextField).addLeftPadding()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.backGroundView.backgroundColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var result: Int
        result = collectionView == self.photoCollection ? photos.count : keywords.count
        return result
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if collectionView == self.photoCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionCell
            cell.chosenPhoto.image = UIImage(named: photos[indexPath.row])
            cell.layer.cornerRadius = 20.0
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "keywordCell", for: indexPath) as! KeywordCollectionCell
            cell.customizeButton(indexPath)
            cell.keywordButton.setTitle(keywords[indexPath.item].name, for: .normal)
            return cell
        }
    }
    // 셀 너비 동적으로 조절하는 함수
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: keywords[indexPath.item].name.size(withAttributes: [NSAttributedString.Key : UIFont.systemFont(ofSize: 14)]).width + 20, height: 38)
    //    }
}


// textField corner 둥글게, 보더 적용하는 함수
func borderRadius(view: UITextField) -> UITextField{
    view.layer.cornerRadius = 19.0
    view.layer.borderWidth = 1.0
    view.layer.borderColor = UIColor.systemGray5.cgColor
    view.layer.masksToBounds = true
    return view
}

// textField 안에서 왼쪽 Padding 주는 함수
extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}

struct Keyword {
    let name: String
    var state: Bool = false
}
