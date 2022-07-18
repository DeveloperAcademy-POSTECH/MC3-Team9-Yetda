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
    
    var photos: [String] = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        borderRadius(view: giftNameTextField).addLeftPadding()
        borderRadius(view: giftRecipientTextField).addLeftPadding()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionCell
        cell.chosenPhoto.image = UIImage(named: photos[indexPath.row])
        cell.layer.cornerRadius = 20.0
        return cell
    }
    
    // textField corner 둥글게, 보더 적용하는 함수
    func borderRadius(view: UITextField) -> UITextField{
        view.layer.cornerRadius = 19.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.masksToBounds = true
        return view
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
