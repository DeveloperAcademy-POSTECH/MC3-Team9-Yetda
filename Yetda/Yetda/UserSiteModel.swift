//
//  UserSiteModel.swift
//  Yetda
//
//  Created by rbwo on 2022/07/28.
//

import Foundation
import Combine

public let defaults = UserDefaults.standard

class UserSiteModel {
    static let shared = UserSiteModel()
    
    @Published var mysiteArray: [String] = []
}
