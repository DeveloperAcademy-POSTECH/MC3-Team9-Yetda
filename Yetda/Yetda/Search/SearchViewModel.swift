//
//  SearchViewModel.swift
//  Yetda
//
//  Created by rbwo on 2022/07/26.
//

import Foundation
import Combine

final class SearchViewModel {
    
    static let shared = SearchViewModel()
    
    @Published var resultData: [String] = []
    
    let siteDidTapped = PassthroughSubject<String, Never>()
    
    func filterdData(text: String) {
        if text.count > 0 {
            let array = SearchModel.dataModel.filter { $0.contains(text) }
            self.resultData = array
        } else {
            self.resultData.removeAll()
        }
    }
}
