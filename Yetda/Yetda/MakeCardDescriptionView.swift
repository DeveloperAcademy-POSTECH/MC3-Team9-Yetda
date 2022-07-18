//
//  MakeCardDescriptionView.swift
//  Yetda
//
//  Created by Youngseo Yoon on 2022/07/18.
//

import UIKit

class MakeCardDescriptionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var locationLabel: UILabel!
    
    var photos: [String] = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
