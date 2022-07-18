//
//  CardListViewModel.swift
//  Yetda
//
//  Created by 이채민 on 2022/07/18.
//

import Foundation
import SwiftUI

class CardListViewModel: ObservableObject {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Present.id, ascending: true)],
        animation: .default)
    
    private var presentData: FetchedResults<Present>
    
    func getPresentList() {
        // TODO: 모든 카드 리스트 호출
    }
    
    func getPresentAt(_ index: IndexPath) -> Present? {
        // TODO: 일단 이렇게 작성해둠 index로 해당 카드 호출해야 함
        return presentData.randomElement()
    }
    
    func didSelect(_ index: IndexPath) {
        // TODO: 카드 눌렀을 때
    }
}
