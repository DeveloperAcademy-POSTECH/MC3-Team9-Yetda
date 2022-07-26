//
//  MakeCardDescriptionViewController.swift
//  Yetda
//
//  Created by Youngseo Yoon on 2022/07/18.
//

import UIKit
import RxSwift
import RxCocoa

class MakeCardDescriptionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var giftNameTextField: UITextField!
    @IBOutlet weak var giftRecipientTextField: UITextField!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var keywordCollection: UICollectionView!
    
//    var count: Int = 0
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

        giftNameTextField?.delegate = self
        giftRecipientTextField?.delegate = self
        
        if let giftNameTextField = giftNameTextField {borderRadius(giftNameTextField).addLeftPadding()}
        if let giftRecipientTextField = giftRecipientTextField {borderRadius( giftRecipientTextField).addLeftPadding()}
        self.hideKeyboardWhenTappedAround()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var result: Int
        result = collectionView == self.photoCollection ? photos.count : keywords.count
        return result
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.photoCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionCell
            cell.chosenPhotoDescription.image = UIImage(named: photos[indexPath.row])
            cell.layer.cornerRadius = 10.0
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "keywordCell", for: indexPath) as! KeywordCollectionCell
            cell.keywordButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            cell.initButton()
            cell.setButton(keywords[indexPath.row].state)
            cell.keywordButton.setTitle(keywords[indexPath.item].name, for: .normal)
            return cell
        }
    }
    
    // 다음 뷰에 키워드를 담은 배열 값을 넘겨줄 준비
    func prepareKeyword() -> [Keyword] {
        var results: [Keyword] = []
        
        for keyword in keywords {
            if keyword.state {
                results.append(keyword)
            }
        }
        
        return results
    }
    
    // 셀에 있어 내가 적용시킬 변화는 controller에서 적용시키는 것이 좋음
    @objc func didTapButton(_ sender: UIButton) {
//        var number = 0
//        for keyword in keywords {
//            if keyword.state {
//                number += 1
//            }
//        }
//        if number > 4 {
//
//        }
        
        // contains 메소드는 아래의 for문을 돌리는 것과 같은 결과(Bool값)를 출력함. -> Equatable 타입일 때만 사용 가능한 메소드
//        keywords.contains(<#T##element: Keyword##Keyword#>)
//
//        for keyword in keywords {
//            if keyword == element {
//                return true
//            }
//        }
//        return false
        
        // button이 tap이 되었을 때 실행되는 함수로, keyword를 돌리면서 누른 값에 해당하는 keyword를 찾아 그 state를 true로 바꿔줌
        // 반드시 reloadData를 해주면서 전체 cell을 업데이트를 해줘야만 이게 반영이 됨
        for keyword in keywords {
            if keyword.name == sender.title(for: .normal) {
                keyword.state.toggle()
                keywordCollection.reloadData()
                return
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = CGColor(red: 211/255, green: 225/255, blue: 253/255, alpha: 1)
        textField.backgroundColor = UIColor(red: 211/255, green: 225/255, blue: 253/255, alpha: 0.1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        borderRadius(textField)
    }
    
    // textField corner 둥글게, 보더 적용하는 함수
    func borderRadius(_ textField: UITextField) -> UITextField{
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 19.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.backgroundColor = UIColor.white
        return textField
    }
}

class Keyword: Equatable {
    // Keyword는 내가 따로 구현한 타입이기 때문에 Int, String과 같이 비교할 수 있는 기준이 없음.
    // 따라서 Equatable로 변경하면서 어떤 값을 기준으로 변경할 것인지 알려주기~ * ex) 앞에 인자, 뒤에 인자를 비교해서 Bool 값을 알려줄 거예요~
    static func == (firstKeyword: Keyword, secondKeyword: Keyword) -> Bool {
        return firstKeyword.name == secondKeyword.name
    }
    
    var name: String = ""
    var state: Bool = false
    
    init(name: String, state: Bool) {
        self.name = name
        self.state = state
    }
    
    func findKeyword(name: String) -> Bool {
        if self.name == name {
            return true
        } else {
            return false
        }
    }
}

// textField 안에서 왼쪽 Padding 주는 함수
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
