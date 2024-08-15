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

public struct HomeView: View {
    
    @Bindable public var store: StoreOf<HomeFeature>
    
    public init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
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
                store.send(.onAppear)
            }
            .overlay {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .isHidden(!store.isLoading, remove: true)
                
                if let store = store.scope(state: \.destination?.missionDeleteAlert, action: \.destination.missionDeleteAlert) {
                    MissionDeleteAlertView(store: store)
                }
                if let store = store.scope(state: \.destination?.missionInvitationInfo, action: \.destination.missionInvitationInfo) {
                    InvitationInfoView(store: store)
                }
                if let store = store.scope(state: \.destination?.certificationResult, action: \.destination.certificationResult) {
                    VerificationResultView(store: store)
                }
            }
            .fullScreenCover(item: $store.scope(state: \.destination?.imageUpload, action: \.destination.imageUpload)) { store in
                ImageUploadView(store: store)
            }
            .fullScreenCover(item: $store.scope(state: \.destination?.imageDetail, action: \.destination.imageDetail)) { store in
                ImageDetailView(store: store)
            }
            .fullScreenCover(item: $store.scope(state: \.destination?.finish, action: \.destination.finish), content: { store in
                FinishView(store: store)
            })
        } destination: { store in
            switch store.case {
            case let .missionInfo(store):
                MissionInfoView(store: store)
            }
        }
    }
}

extension HomeView {
    
    enum Constant {
        static let horizontalPadding: CGFloat = 24
    }
}
