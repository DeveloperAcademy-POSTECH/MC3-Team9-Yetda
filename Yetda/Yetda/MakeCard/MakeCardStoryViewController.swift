//
//  MakeCardStoryViewController.swift
//  Yetda
//
//  Created by Youngseo Yoon on 2022/07/21.
//

import UIKit

class MakeCardStoryViewController: UIViewController, UICollectionViewDelegate, UITextViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var numbersTyped: UILabel!
    
    var activeField: UITextField? = nil
    var photos: [String] = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    var isKeyboardShowing: Bool = false
    @IBOutlet weak var storyTypeLimit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyTextView.delegate = self
        storyTextView.text = "입력하기"
        storyTextView.textColor = UIColor(named: "YettdaMainGray")
        storyTypeLimit.text = "0/200"
        customTextView(storyTextView)

        textViewDidBeginEditing(storyTextView)
        textViewDidEndEditing(storyTextView)
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell2", for: indexPath) as! PhotoCollectionCell
        cell.chosenPhotoStory.image = UIImage(named: photos[indexPath.row])
        cell.layer.cornerRadius = 10.0
        return cell
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(named: "YettdaMainGray") {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(named: "YettdaMainLightBlue")?.cgColor
        textView.layer.backgroundColor = CGColor(red: 211/255, green: 225/255, blue: 253/255, alpha: 0.1)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "입력하기"
            textView.textColor = UIColor(named: "YettdaMainGray")
        }
        customTextView(textView)
    }
    
    func customTextView(_ textView: UITextView) {
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.layer.backgroundColor = UIColor.white.cgColor
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 20.0
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(named: "YettdaMainGray")?.cgColor
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if isKeyboardShowing == false {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardHeight = keyboardFrame.cgRectValue.height
                let bottomSpace = self.view.frame.height - (storyTextView.frame.origin.y + storyTextView.frame.height)
                self.view.frame.origin.y -= keyboardHeight - bottomSpace + 70
            }
            isKeyboardShowing.toggle()
        }
        else {
            return
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        isKeyboardShowing.toggle()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = storyTextView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {return false}
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        numbersTyped.text = "\(changedText.count)/200"
        
        // 키보드의 백버튼이 적용되고 값이 줄어들게한다
        if let char =  text.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        
        guard textView.text!.count < 200 else {return false}
        
        return true
    }
}
