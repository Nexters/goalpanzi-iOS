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
import DomainBoardInterface
import DomainPlayerInterface

public struct HomeView: View {
    
    public let store: StoreOf<HomeFeature>
    
    public init(store: StoreOf<HomeFeature>) {
        self.store = store
        SharedDesignSystemFontFamily.registerAllCustomFonts()
    }
    
    public var body: some View {
        MainView(store: store)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

private struct MainView: View {
    
    let store: StoreOf<HomeFeature>
    
    enum Constant {
        static let horizontalPadding: CGFloat = 24
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    GeometryReader { reader in
                        CompetitionContentView(reader: reader, store: store)
                        HomeTopView()
                    }
                }
                HomeBottomView(store: store)
                    .isHidden(store.competition.board.isDisabled)
            }
        }
    }
    
    func HomeBottomView(store: StoreOf<HomeFeature>) -> some View {
        VStack {
            HStack(spacing: 8){
                SharedDesignSystemAsset.Images.timeFill.swiftUIImage
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                Text(store.certificationButtonState.info)
                    .font(.pretendard(kind: .body_lg, type: .bold))
                    .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
            }
            .padding(.top, 16)
            .padding(.bottom, 6)
            
            Button(action: {
                store.send(.didTapCertificationButton)
            }) {
                Text(store.certificationButtonState.title)
                    .font(.pretendard(kind: .body_lg, type: .bold))
                    .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(
                        store.certificationButtonState.isEnabled
                        ? SharedDesignSystemAsset.Colors.orange.swiftUIColor
                        : SharedDesignSystemAsset.Colors.disabled.swiftUIColor
                    )
                    .cornerRadius(30)
            }
            .padding(.horizontal, Constant.horizontalPadding)
            .padding(.bottom, 36)
            .disabled(!store.certificationButtonState.isEnabled)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .frame(height: 60)
    }
    
    func CompetitionContentView(reader: GeometryProxy, store: StoreOf<HomeFeature>) -> some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 4) {
                    CompetitionInfoView(store: store)
                    BoardView(reader: reader, store: store)
                }
                .padding(.top, 167)
                .padding(.horizontal, Constant.horizontalPadding)
                .padding(.bottom, 142)
            }
            .background {
                store.competition.board.theme.backgroundImageAsset.swiftUIImage
                   .resizable()
                   .scaledToFill()
                   .edgesIgnoringSafeArea(.all)
            }
            .scrollDisabled(store.competition.board.isDisabled)
            
            if store.competition.board.isDisabled {
                NotStartedInfoView(me: store.competition.findMe())
                    .padding(.top, 167)
            }
        }
    }
    
    func NotStartedInfoView(me: Player?) -> some View {
        
        ZStack {
            me?.character.imageAsset.swiftUIImage
                .resizable()
                .frame(width: 240, height: 240)
                .offset(y: 51)
            
            SharedDesignSystemAsset.Images.notStartedInfoToolTip.swiftUIImage
                .resizable()
                .frame(width: 276, height: 96)
                .offset(y: -110)
            
        }
    }
    
    func HomeTopView() -> some View {
        VStack(spacing: 0) {
            NavigationBarView()
            StoryView()
        }
        .background(.ultraThinMaterial)
    }
    
    func NavigationBarView() -> some View {
        ZStack {
            HStack(alignment: .center) {
                Button(action: {
                    store.send(.didTapMissionInfoButton)
                }) {
                    SharedDesignSystemAsset.Images.flagFill.swiftUIImage
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                }
                .overlay {
                    SharedDesignSystemAsset.Images.missionInfoGuideToolTip.swiftUIImage
                        .resizable()
                        .frame(width: 161, height: 72)
                        .offset(x: 50, y: 50)
                        .isHidden(store.isMissionInfoGuideToolTipShowed)
                        .onTapGesture {
                            store.send(.didTapMissionInfoGuideToolTip)
                        }
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: {
                        store.send(.didTapInvitationInfoButton)
                    }) {
                        SharedDesignSystemAsset.Images.userAddFill.swiftUIImage
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                    }
                    .isHidden(!store.competition.board.isDisabled)
                    .overlay {
                        SharedDesignSystemAsset.Images.invitationCodeGuideToolTip.swiftUIImage
                            .resizable()
                            .frame(width: 161, height: 72)
                            .offset(x: -42, y: 50)
                            .isHidden(store.isInvitationGuideToolTipShowed)
                            .onTapGesture {
                                print("!!!!")
                                store.send(.didTapInvitatoinInfoToolTip)
                            }
                    }
                    
                    Button(action: {
                        store.send(.didTapSettingButton)
                    }) {
                        SharedDesignSystemAsset.Images.settingFill.swiftUIImage
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                    }
                }
                
            }
            
            Text(store.mission.description)
                .font(.pretendard(kind: .title_lg, type: .bold))
                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
        }
        .padding(.horizontal, 24)
        .frame(height: 45)
        .zIndex(999)
    }
    
    func StoryView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(store.competition.players) { player in
                    PlayerView(player: player)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 14)
            .padding(.horizontal, 23)
        }
        .frame(height: 122)
    }
    
    func PlayerView(player: DomainPlayerInterface.Player) -> some View {
        VStack(alignment: .center, spacing: 6) {
            ZStack(alignment: .top) {
                Button(action: {
                    store.send(.didTapPlayer(player: player))
                }) {
                    if player.isCertificated {
                        player.character.imageAsset.swiftUIImage
                            .resizable()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    } else {
                        player.character.imageAsset.swiftUIImage
                            .resizable()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    }
                }
                if player.isMe {
                    Text("나")
                        .font(.pretendard(kind: .body_md, type: .bold))
                        .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                        .frame(width: 40, height: 18)
                        .background(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                        .clipShape(Capsule())
                        .offset(y: -10)
                }
            }
            
            Text("\(player.name)")
                .font(.pretendard(kind: .body_sm, type: .medium))
                .lineLimit(1)
                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                .frame(width: 70, height: 20)
                .background(SharedDesignSystemAsset.Colors.gray5.swiftUIColor.opacity(0.5))
                .clipShape(Capsule())
                .overlay(Capsule().stroke(SharedDesignSystemAsset.Colors.white.swiftUIColor.opacity(0.5), lineWidth: 1))
                
        }
    }
    
    
    func CompetitionInfoView(store: StoreOf<HomeFeature>) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(store.competition.info[.title] ?? "")
                .font(.pretendard(kind: .heading_md, type: .bold))
                .foregroundStyle(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
            Text(store.competition.info[.subtitle] ?? "")
                .font(.pretendard(kind: .body_lg, type: .bold))
                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor.opacity(0.5))
        }
        .padding(.top, 28)
        .padding(.bottom, 16)
    }
    
    func BoardView(reader: GeometryProxy, store: StoreOf<HomeFeature>) -> some View {
        let numberOfRows = store.competition.board.numberOfRows
        let numberOfColumns = store.competition.board.numberOfColumns
        return Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<numberOfRows, id: \.self) { row in
                GridRow {
                    let indices = Array((0..<numberOfColumns))
                    ForEach((row % 2 == 0) ? indices : indices.reversed(), id: \.self) { col in
                        let index = col + (row * numberOfColumns)
                        BlockView(
                            block: store.competition.board.findBlock(by: Position(index: index)),
                            width: (reader.size.width - Constant.horizontalPadding * 2.0) / CGFloat(numberOfColumns)
                        )
                    }
                }
            }
        }
        .padding(.top, 4)
    }
}

private struct BlockView: View {
    
    let block: Block?
    
    let width: CGFloat
    
    var body: some View {
        ZStack(alignment: .center) {
            if let block {
                if block.isStartBlock, !block.isDisabled {
                    block.theme.startImageAsset.swiftUIImage
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                    
                } else if block.isStartBlock, block.isDisabled {
                    block.theme.startImageAsset.swiftUIImage
                        .resizable()
                        .opacity(0.5)
                        .aspectRatio(1.0, contentMode: .fit)
                    
                } else if block.isConquered, !block.isDisabled {
                    block.theme.conqueredImageAsset(kind: block.kind).swiftUIImage
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                    
                } else {
                    block.theme.normalImageAsset(kind: block.kind, disabled: block.isDisabled).swiftUIImage
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                }
                
                if block.isStartBlock {
                    Text("START")
                        .font(.pretendard(kind: .title_lg, type: .bold))
                        .foregroundStyle(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                    
                } else if block.isLastBlock {
                    Text("GOAL")
                        .font(.pretendard(kind: .title_lg, type: .bold))
                        .foregroundStyle(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                }
            } else {
                EmptyView()
            }
        }
    }
}
