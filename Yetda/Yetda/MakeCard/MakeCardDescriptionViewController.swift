//
//  MakeCardDescriptionViewController.swift
//  Yetda
//
//  Created by Youngseo Yoon on 2022/07/18.
//

import UIKit

class MakeCardDescriptionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var giftNameTextField: UITextField!
    @IBOutlet weak var giftRecipientTextField: UITextField!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var keywordCollection: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func sendKeywordList(_ sender: Any) {
        prepareKeyword()
    }
    
    var activeField: UITextField? = nil
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
        
        setUpUI()
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
    
    // 키워드 state 토글해주고 값 제한하는 함수
    @objc func didTapButton(_ sender: UIButton) {
        
        var number = 0
        
        for keyword in keywords {
            if keyword.state == true {
                number += 1
            }
        }
        
        for keyword in keywords {
            if keyword.name == sender.title(for: .normal) {
                keyword.state.toggle()
                if number<4 && (keyword.state == true){
                    number += 1
                } else if number >= 4 && (keyword.state == false) {
                    number -= 1
                } else if number >= 4 && (keyword.state == true){
                    keyword.state.toggle()
                } else {
                    number -= 1
                }
                keywordCollection.reloadData()
                print(number)
                return
            }
        }
        print(number)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(named: "YettdaMainLightBlue")?.cgColor
        textField.backgroundColor = UIColor(red: 211/255, green: 225/255, blue: 253/255, alpha: 0.1)
        self.activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        borderRadius(textField)
        self.activeField = nil
    }
    
    private func setUpUI() {
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(greaterThanOrEqualTo: photoCollection.bottomAnchor, constant: 100)
        ])
    }
    
    // 글자수 15자 입력 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let char =  string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 15 else {return false}
        return true
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

class Keyword {
    
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
