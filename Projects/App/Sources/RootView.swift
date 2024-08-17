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
import FeatureEntranceInterface
import FeaturePieceCreationInterface
import FeatureHomeInterface
import SharedDesignSystem

struct RootView: View {
    
    @Bindable var store: StoreOf<RootFeature>
    
    init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    @ViewBuilder
    var body: some View {
        Group {
            NavigationStack(
                path: $store.scope(state: \.path, action: \.path)
            ) {
                rootView
            } destination: { store in
                switch store.case {
                case let .login(store):
                    LoginView(store: store)
                }
            }
        }
        .task {
            await store.send(.didLoad).finish()
        }
    }
    
    @ViewBuilder
    var rootView: some View {
        switch store.state.destination {
        case .login:
            if let store = store.scope(state: \.destination?.login, action: \.destination.login) {
                LoginView(store: store)
            }
            
        case .profileCreation:
            if let store = store.scope(state: \.destination?.profileCreation, action: \.destination.profileCreation) {
                PieceCreationView(store: store)
            }
            
        case .entrance:
            if let store = store.scope(state: \.destination?.entrance, action: \.destination.entrance) {
                EntranceView(store: store)
            }
            
        case .home:
            if let store = store.scope(state: \.destination?.home, action: \.destination.home) {
                HomeView(store: store)
            }
            
        case .none:
            EmptyView()
        }
    }
}
