//
//  MakeCardStoryViewController.swift
//  Yetda
//
//  Created by Youngseo Yoon on 2022/07/21.
//

import UIKit

class MakeCardStoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    var photos: [String] = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    @IBOutlet weak var storyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyTextView.delegate = self
        storyTextView.text = "입력하기"
        storyTextView.textColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        customTextView(storyTextView)
        textViewDidBeginEditing(storyTextView)
        textViewDidEndEditing(storyTextView)
        self.hideKeyboardWhenTappedAround()
//         Do any additional setup after loading the view.
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
        if textView.textColor == UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor(red: 211/255, green: 225/255, blue: 253/255, alpha: 1)
        textView.layer.backgroundColor = CGColor(red: 211/255, green: 225/255, blue: 253/255, alpha: 0.1)
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "입력하기"
            textView.textColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        }
        customTextView(textView)
    }
    func customTextView(_ textView: UITextView) {
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.layer.backgroundColor = UIColor.white.cgColor
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 20.0
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
    }
}
