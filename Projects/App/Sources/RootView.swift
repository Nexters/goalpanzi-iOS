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
import SharedDesignSystem

struct RootView: View {
    
    @Bindable var store: StoreOf<RootFeature>
    
    init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    @ViewBuilder
    var body: some View {
        rootView
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

        case .main:
            if let store = store.scope(state: \.destination?.main, action: \.destination.main) {
                MainView(store: store)
            }
            
        case .none:
            GeometryReader { proxy in
                VStack(alignment: .center, spacing: 0) {
                    SharedDesignSystemAsset.Images.missionmateLogo.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .background(Color.mmOrange)
            }
            .ignoresSafeArea(.all)
        }
    }
}
