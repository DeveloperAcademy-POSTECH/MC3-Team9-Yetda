//
//  FirebaseFirestoreManager.swift
//  Yetda
//
//  Created by Geunil Park on 2022/07/28.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    
    // id 값이 있는 경우에는 수정, 없는 경우에는 UUID를 새롭게 만들어서 넣어줌.
    static func uploadData(present: Present) {
        let db = Firestore.firestore()
        var documentId: String = ""
        if let id = present.id { documentId = id } else { documentId = UUID().uuidString }
        let stringData: [String: Any] = ["id": documentId,
                                         "user": present.user,
                                         "site": present.site,
                                         "name": present.name,
                                         "content": present.content,
                                         "whosFor": present.whosFor,
                                         "date": present.date,
                                         "keyWords": present.keyWords,
                                         "images": present.images,
                                         "coordinate": present.coordinate]
        
        db.collection("presents").document(documentId).setData(stringData) { err in
            if let err = err {
                print("ERROR Writing document: \(err)")
            } else {
                print()
            }
        }
    }
    
    static func deleteData(present: Present) {
        let db = Firestore.firestore()
    
        if let id = present.id {
            db.collection("presents").document(id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        } else {
            print("It's not in DB")
        }
    }
}