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
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell2", for: indexPath) as! PhotoCollectionCell
        cell.chosenPhotoStory.image = UIImage(named: photos[indexPath.row])
        cell.layer.cornerRadius = 10.0
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
