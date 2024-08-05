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
import SharedDesignSystem

struct RootView: View {
    
    @Bindable var store: StoreOf<RootFeature>
    
    init(store: StoreOf<RootFeature>) {
        self.store = store
        SharedDesignSystemFontFamily.registerAllCustomFonts()
    }
    
    var body: some View {
        Group {
            switch store.state.destination {
            case .login:
                if let store = store.scope(state: \.destination?.login, action: \.destination.login) {
                    NavigationStack(
                        path: $store.scope(state: \.path, action: \.path)
                    ) {
                        LoginView(store: store)
                    } destination: { store in
                        switch store.case {
                        case let .login(store):
                            LoginView(store: store)
                        }
                    }
                }
            case .none:
                EmptyView()
            }
        }
        .task {
            store.send(.didLoad)
        }
    }
}
