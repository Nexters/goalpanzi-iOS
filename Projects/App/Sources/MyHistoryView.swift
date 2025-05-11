//
//  MyHistoryView.swift
//  MissionMate
//
//  Created by Haeseok Lee on 5/11/25.
//

import SwiftUI
import ComposableArchitecture

struct MyHistoryView: View {
    
    @Bindable var store: StoreOf<MyHistoryFeature>
    
    init(store: StoreOf<MyHistoryFeature>) {
        self.store = store
    }
    
    @ViewBuilder
    var body: some View {
        EmptyView()
    }
}
