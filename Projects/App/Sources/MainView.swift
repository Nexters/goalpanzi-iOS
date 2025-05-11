//
//  MainView.swift
//  MissionMate
//
//  Created by Haeseok Lee on 5/11/25.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import SharedUtil
import SharedDesignSystem
import FeatureHomeInterface
import FeatureSettingInterface

struct MainView: View {
    
    @Bindable var store: StoreOf<MainFeature>
    
    init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
            switch store.focusedTab {
            case .home:
                if let store = store.scope(state: \.homeState, action: \.home) {
                    HomeView(store: store)
                }

            case .myHistory:
                if let store = store.scope(state: \.myHistoryState, action: \.myHistory) {
                    MyHistoryView(store: store)
                }
                
            case .setting:
                if let store = store.scope(state: \.settingState, action: \.setting) {
                    SettingView(store: store)
                }
                
            }
            Tab(
                focusedTab: store.focusedTab,
                tabs: MainFeature.TabKind.allCases,
                didTapItem: { tab in
                    store.send(.didTapTab(tab))
                }
            )
            .background(Color.mmWhite)
        }
    }
}

extension MainView {
    
    struct Tab: View {
        
        var body: some View {
            VStack {
                Spacer()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1.0)
                    .background(Color.mmGray5)
                HStack(alignment: .center, spacing: 0) {
                    ForEach(tabs) { tab in
                        Item(
                            icon: tab.icon,
                            title: tab.title,
                            isFocused: focusedTab == tab
                        )
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            didTapItem?(tab)
                        }
                    }
                }
                .frame(height: 54)
            }
        }
        
        var focusedTab: MainFeature.TabKind
        var tabs: [MainFeature.TabKind]
        var didTapItem: ((MainFeature.TabKind) -> Void)?
    }
}

extension MainView.Tab {
    
    struct Item: View {
        
        var body: some View {
            VStack(alignment: .center, spacing: 3) {
                icon
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(iconColor)
                    .frame(width: 24, height: 24)
                    
                Text(title)
                    .font(.pretendard(kind: .body_md, type: .regular))
                    .foregroundStyle(textColor)
            }
        }
        
        let icon: Image
        let title: String
        let isFocused: Bool
        private var iconColor: Color {
            isFocused ? .mmOrange : .mmGray1
        }
        private var textColor: Color { iconColor }
    }
}

extension MainFeature.TabKind: Identifiable {
    
    var id: String {
        switch self {
        case .home: "home"
        case .myHistory: "myHistory"
        case .setting: "setting"
        }
    }
}

extension MainFeature.TabKind: Equatable {
    
    static func == (lhs: MainFeature.TabKind, rhs: MainFeature.TabKind) -> Bool {
        lhs.id == rhs.id
    }
}

extension MainFeature.TabKind: CaseIterable {
    
    static var allCases: [MainFeature.TabKind] {
        [.home, .myHistory, .setting]
    }
}

extension MainFeature.TabKind {
    
    var icon: Image {
        switch self {
        case .home: SharedDesignSystemAsset.Images.flagIcon.swiftUIImage
        case .myHistory: SharedDesignSystemAsset.Images.clockIcon.swiftUIImage
        case .setting: SharedDesignSystemAsset.Images.settingIcon.swiftUIImage
        }
    }
    
    var title: String {
        switch self {
        case .home: "진행미션"
        case .myHistory: "내기록"
        case .setting: "설정"
        }
    }
}
