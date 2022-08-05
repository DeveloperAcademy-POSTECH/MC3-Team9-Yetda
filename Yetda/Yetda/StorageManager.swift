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
    
    static func uploadImages(images: [UIImage], completion: @escaping ([String?]) -> Void) {
        
        print("uploadImage 시작")
        var result = [String?]()
        
        let group = DispatchGroup()
        
        for image in images {
            group.enter()
            uploadImage(image: image, completion: setResult )
        }
        
        func setResult(url: String?) {
            result.append(url)
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(result)
            return
        }
    }
    
    static func uploadImage(image: UIImage?, completion: @escaping (String?) -> Void) {
        print("이미지 업로드 시작")
        guard let image = image else {
            print("이미지가 없음")
            completion(nil)
            return
        }
        guard let imageData = image.jpegData(compressionQuality: 0.4) else {
            print("이미지데이터가 없음")
            completion(nil)
            return
        }
        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
        
        let storegeRef = Storage.storage().reference()
        let imageRef = storegeRef.child("\(imageName)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
          guard let metadata = metadata else {
              print("메타데이터가 없음")
              completion(nil)
              return
          }
          let size = metadata.size
          imageRef.downloadURL { (url, error) in
              guard let downloadURL = url else {
                  print("다운로드URL이 없음")
                  completion(nil)
                  return
              }
              print("업로드 이미지 제대로 작동함")
              completion(downloadURL.absoluteString)
          }
        }
    }
    
    static func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
    //        let ourURL = "gs://yetda-5f2c3.appspot.com/"
            let imageRef = Storage.storage().reference(forURL: urlString)
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
