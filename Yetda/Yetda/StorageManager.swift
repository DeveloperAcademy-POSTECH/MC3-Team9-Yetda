//
//  FirebaseStorageManager.swift
//  Yetda
//
//  Created by Geunil Park on 2022/07/28.
//

import UIKit
import Firebase
import FirebaseStorage

class StorageManager {
    
    static func uploadImages(images: [UIImage]) -> [String] {
        var result = [String]()
        
        for image in images {
            result.append(uploadImage(image: image))
        }
        
        return result
    }

    static func uploadImage(image: UIImage?) -> String {
        
        guard let image = image else { return "" }
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return "" }
        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
        
        let storegeRef = Storage.storage().reference()
        let imageRef = storegeRef.child("\(imageName)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata)
        
        return imageName
    }
    
    static func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
    //        let ourURL = "gs://yetda-5f2c3.appspot.com/"
            let imageRef = Storage.storage().reference(forURL: "gs://yetda-5f2c3.appspot.com/" + urlString)
    //        let storageReference = imageRef.child(urlString)
            let megaByte = Int64(1 * 4096 * 4096)
            
            imageRef.getData(maxSize: megaByte) { data, error in
                guard let imageData = data else {
                    print("Image Download Error: \(error?.localizedDescription)")
                    completion(nil)
                    return
                }
                print("이미지 가져오기 성공")
                completion(UIImage(data: imageData))
            }
        }
}
