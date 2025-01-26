//
//  HomeView.swift
//  FeatureHome
//
//  Created by Haeseok Lee on 7/24/24.
//

import SwiftUI
import SharedUtil
import SharedDesignSystem
import ComposableArchitecture
import DomainCompetitionInterface
import DomainBoardInterface
import DomainPlayerInterface
import FeatureSettingInterface

public struct HomeView: View {
    
    @Bindable public var store: StoreOf<HomeFeature>
    
    public init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    ZStack(alignment: .top) {
                        GeometryReader { proxy in
                            CompetitionContentView(proxy: proxy, store: store)
                            VStack(spacing: 0) {
                                HomeNavigationBarView(store: store)
                                StoryView(store: store)
                            }
                            .background(.ultraThinMaterial)
                        }
                    }
                    HomeBottomView(store: store)
                        .isHidden(store.competition?.board.isDisabled == true)
                }
            }
            .task {
                await store.send(.onAppear).finish()
            }
            .overlay {
                
                if let store = store.scope(state: \.destination?.missionDeleteAlert, action: \.destination.missionDeleteAlert) {
                    MissionDeleteAlertView(store: store)
                }
                if let store = store.scope(state: \.destination?.missionInvitationInfo, action: \.destination.missionInvitationInfo) {
                    InvitationInfoView(store: store)
                }
                if let store = store.scope(state: \.destination?.verificationResult, action: \.destination.verificationResult) {
                    VerificationResultView(store: store)
                }
            }
            .fullScreenCover(item: $store.scope(state: \.destination?.imageUpload, action: \.destination.imageUpload)) { store in
                ImageUploadView(store: store)
            }
            .fullScreenCover(item: $store.scope(state: \.destination?.imageDetail, action: \.destination.imageDetail)) { store in
                ImageDetailView(store: store)
            }
        } destination: { store in
            switch store.case {
            case let .setting(store):
                SettingView(store: store)
            case let .missionInfo(store):
                MissionInfoView(store: store)
            case let .finish(store):
                FinishView(store: store)
            }
        }
    }
}

extension HomeView {
    
    enum Constant {
        static let horizontalPadding: CGFloat = 24
    }
}
