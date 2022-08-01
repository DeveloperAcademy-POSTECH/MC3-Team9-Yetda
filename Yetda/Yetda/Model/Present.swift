//
//  Present.swift
//  Yetda
//
//  Created by Geunil Park on 2022/07/27.
//

import Foundation
import SwiftUI

struct Present: Hashable, Codable {
    let id: String?
    var user: String
    var site: String
    var name: String
    var content: String
    var whosFor: String
    var date: String
    var keyWords: [String]
    var images: [String]
    var coordinate: [String]
    
    init(id: String?, user: String, site: String, name: String, content: String, whosFor: String, date: String, keyWords: [String], images: [String], coordinate: [String]) {
        self.id = id
        self.user = user
        self.site = site
        self.name = name
        self.content = content
        self.whosFor = whosFor
        self.date = date
        self.keyWords = keyWords
        self.images = images
        self.coordinate = coordinate
    }
}
