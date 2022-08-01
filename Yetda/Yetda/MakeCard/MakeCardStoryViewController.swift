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
    @IBOutlet weak var storyTypeLimit: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButton(_ sender: Any) {
        
        // 데이터 저장로직 누르자마자 저장 로직과는 별개로 바로 이동할 수 있도록 비동기로 처리함
        // 애초에 데이터 저장하고 넘어가는 UI를 실행하는 것은 텀이 생기게 돼서 iOS에서 터트림.
        DispatchQueue.global().sync {
            let images: [UIImage]? = photos
            let imageURLs: [String] = StorageManager.uploadImages(images: images!)
            FirestoreManager.uploadData(present: Present(id: nil,
                                                         user: "testUser",
                                                         site: "testSite",
                                                         name: "\(giftNameData)",
                                                         content: "\(storyTextView.text ?? "")",
                                                         whosFor: "\(giftRecipientData)",
                                                         date: "testDate",
                                                         keyWords: keywordsData,
                                                         images: imageURLs,
                                                         coordinate: ["coordinate1", "coordinate2"]))
        }

        let homeVC = HomeViewController(city: defaults.string(forKey: "site"))
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: true)
    }
    
    var activeField: UITextField? = nil
    var isKeyboardShowing: Bool = false
    
    var photos: [UIImage]?
    var giftNameData: String = ""
    var giftRecipientData: String = ""
    var keywordsData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyTextView.delegate = self
        storyTextView.text = "입력하기"
        storyTextView.textColor = UIColor(named: "YettdaMainGray")
        storyTypeLimit.text = "0/200"
        
        nextButton.isUserInteractionEnabled = false
        nextButton.backgroundColor = UIColor(named: "YettdaSubDisabledButton")
        nextButton.layer.cornerRadius = 10
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
        return photos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell2", for: indexPath) as! PhotoCollectionCell
        cell.chosenPhotoStory?.image = photos?[indexPath.row]
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
        customTextView(textView)
        
        if storyTextView.text?.count == 0 {
            textView.text = "입력하기"
            textView.textColor = UIColor(named: "YettdaMainGray")
            self.nextButton.isUserInteractionEnabled = false
            self.nextButton.backgroundColor = UIColor(named: "YettdaSubDisabledButton")
            self.nextButton.layer.cornerRadius = 10
        } else {
            self.nextButton.isUserInteractionEnabled = true
            self.nextButton.backgroundColor = UIColor(named: "YettdaMainBlue")
            self.nextButton.layer.cornerRadius = 10
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // 행간 조절하기 -> Font를 다시 지정해주지 않으면 기존 폰트로 돌아감
        let attrString = NSMutableAttributedString(string: textView.text!, attributes: [ NSAttributedString.Key.font: UIFont(name: "SpoqaHanSansNeo-Regular", size: 15.0)! ])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        textView.attributedText = attrString
    }
    
    func customTextView(_ textView: UITextView) {
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.layer.backgroundColor = UIColor.white.cgColor
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 20.0
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(named: "YettdaMainGray")?.cgColor
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
        
        guard textView.text!.count < 199 else {return false}
        
        return true
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
}

