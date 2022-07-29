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
}
