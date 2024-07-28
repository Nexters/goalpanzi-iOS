//
//  RootView.swift
//  Feature
//
//  Created by Haeseok Lee on 7/28/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import FeatureLoginInterface

struct RootView: View {
    
    let store: StoreOf<RootFeature>
    
    init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    var body: some View {
        switch store.state.destination {
        case .login:
            if let store = store.scope(state: \.destination?.login, action: \.destination.login) {
                LoginView(store: store)
            }
        case .none:
            EmptyView()
        }
    }
}
