//
//  CardDetailViewModel.swift
//  Yetda
//
//  Created by Jinsan Kim on 2022/07/18.
//

import Foundation
import UIKit

class CardDetailViewModel {
    let present: Present
    
    init() {
        self.present = Present()
    }
    
    var name: String? {
        if let name = present.name {
            return name
        } else {
            return ""
        }
    }
    
    var whosFor: String? {
        if let whosFor = present.whosFor {
            return whosFor
        } else {
            return ""
        }
    }
    
    var keyWord: Array<String> {
        if let keyWord = present.keyWord {
            return keyWord.components(separatedBy: "&")
        } else {
            return []
        }
    }
    
    var content: String? {
        if let content = present.content {
            return content
        } else {
            return ""
        }
    }
    
    var location: Array<String> {
        if let location = present.location {
            return location.components(separatedBy: "&")
        } else {
            return []
        }
    }
    
    var images: Array<UIImage> {
        return present.imageArray
    }
}
