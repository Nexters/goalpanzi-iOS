//
//  CompetitionContentView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/15/24.
//

import SwiftUI
import DomainPlayerInterface
import DomainCompetitionInterface
import SharedDesignSystem
import ComposableArchitecture

struct CompetitionContentView: View {
    
    let proxy: GeometryProxy
    let store: StoreOf<HomeFeature>
    
    @State private var isRefreshing: Bool = false
    @State private var refreshControlOpacity: CGFloat = 0
    private let refreshMinOffset: CGFloat = 47
    private let refreshMaxOffset: CGFloat = 214
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { scrollProxy in
                    VStack(alignment: .leading, spacing: 4) {
                        CompetitionInfoView(store: store)
                        BoardView(proxy: proxy, scrollProxy: scrollProxy, store: store)
                    }
                    .padding(.top, 167)
                    .padding(.horizontal, HomeView.Constant.horizontalPadding)
                    .padding(.bottom, 142)
                }
            }
            .onScrollGeometryChange(for: CGFloat.self, of: { geometry in
                geometry.contentOffset.y
            }, action: { _, new in
                refreshControlOpacity = (min(-new, refreshMaxOffset) - (refreshMinOffset)) / (refreshMaxOffset - refreshMinOffset)
            })
            .background {
                store.competition?.board.theme.backgroundImageAsset.swiftUIImage
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
            .refreshable {
                Task {
                    isRefreshing = true
                    await store.send(.didRefresh).finish()
                    isRefreshing = false
                }
            }
            .overlay(alignment: .top) {
                ProgressView()
                    .controlSize(.regular)
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
                    .opacity(refreshControlOpacity)
                    .animation(.easeInOut, value: refreshControlOpacity)
                    .padding(.top, 200)
            }
            
            ProgressView()
                .controlSize(.regular)
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity)
                .isHidden(!store.isLoading || isRefreshing, remove: true)
            
            if store.competition?.board.isDisabled == true {
                NotStartedInfoView(me: store.competition?.me, competitionState: store.competition?.state ?? .disabled)
                    .padding(.top, 167)
                    .allowsHitTesting(false)
            }
        }
    }
}

private struct NotStartedInfoView: View {
    
    let me: Player?
    
    let competitionState: Competition.State
    
    var body: some View {
        ZStack {
            me?.character.basicImage.swiftUIImage
                .resizable()
                .frame(width: 240, height: 240)
                .offset(y: 51)
            
            if competitionState == .notStarted(hasOtherPlayer: true) {
                SharedDesignSystemAsset.Images.notStartedInfoToolTip.swiftUIImage
                    .resizable()
                    .frame(width: 276, height: 96)
                    .offset(y: -110)
            } else if competitionState == .notStarted(hasOtherPlayer: false) {
                SharedDesignSystemAsset.Images.notStartedWarningToolTip.swiftUIImage
                    .resizable()
                    .frame(width: 276, height: 96)
                    .offset(y: -110)
            }
        }
    }
}
