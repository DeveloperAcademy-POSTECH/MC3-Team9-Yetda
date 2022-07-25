//
//  MakeCardStoryViewController.swift
//  Yetda
//
//  Created by Youngseo Yoon on 2022/07/21.
//

import UIKit

class MakeCardStoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var locationLabel: UILabel!
    var photos: [String] = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    @IBOutlet weak var storyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyTextView.text = "입력하기"
        storyTextView.textColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        
        
        storyTextView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        storyTextView.layer.masksToBounds = true
        storyTextView.layer.cornerRadius = 20.0
        storyTextView.layer.borderWidth = 1
        storyTextView.layer.borderColor = CGColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        
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
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "입력하기"
            textView.textColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        }
    }
}
