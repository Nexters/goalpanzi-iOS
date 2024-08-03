//
//  HomeView.swift
//  FeatureHome
//
//  Created by Haeseok Lee on 7/24/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture
import DomainBoardInterface

public struct HomeView: View {
    
    public let store: StoreOf<HomeFeature>
    
    public init(store: StoreOf<HomeFeature>) {
        self.store = store
        // TEST
        SharedDesignSystemFontFamily.registerAllCustomFonts()
    }
    
    public var body: some View {
        MainView(store: store)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

struct MainView: View {
    
    let store: StoreOf<HomeFeature>
    
    let horizontalPadding: CGFloat = 24
    
    func calcBlockWidth(reader: GeometryProxy) -> CGFloat {
        (reader.size.width - horizontalPadding * 2) / 3
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
            }
        }
    }
    
    func HomeBottomView(store: StoreOf<HomeFeature>) -> some View {
        // 하단 버튼
        VStack {
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                Text("미션 요일: 월 화 수 목 금 토")
                    .font(.subheadline)
                    .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
            }
            .padding(.top, 18)
            .padding(.bottom, 4)
            
            Button(action: {
                // 버튼 액션 추가
            }) {
                Text("오늘 미션 인증하기")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                    .cornerRadius(30)
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.bottom, 34)
        }
        .background(.thinMaterial)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .frame(height: 60)
    }
    
    func CompetitionContentView(reader: GeometryProxy, store: StoreOf<HomeFeature>) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 4) {
                CompetitionInfoView()
                BoardView(reader: reader, store: store)
            }
            .padding(.top, 167)
            .padding(.horizontal, horizontalPadding)
            .padding(.bottom, 142)
        }
        .background {
            store.competition.board.theme.backgroundImageAsset.swiftUIImage
               .resizable()
               .scaledToFill()
               .edgesIgnoringSafeArea(.all)
        }
    }
    
    func HomeTopView() -> some View {
        VStack(spacing: 0) {
            NavigationBarView()
            StoryView()
        }
        .background(.thinMaterial)
    }
    
    func NavigationBarView() -> some View {
        HStack(alignment: .center) {
            SharedDesignSystemAsset.Images.flagFill.swiftUIImage
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
            Spacer()
            Text("매일 유산소 1시간")
                .font(.pretendard(kind: .title_lg, type: .bold))
                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
            Spacer()
            SharedDesignSystemAsset.Images.settingFill.swiftUIImage
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
        }
        .padding(.horizontal, 24)
        .frame(height: 45)
    }
    
    func StoryView() -> some View {
        // 캐릭터 리스트 섹션
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(store.competition.players) { player in
                    
                    VStack(alignment: .center, spacing: 6) {
                        ZStack(alignment: .top) {
                            Image("profileImage")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.orange, lineWidth: 3))
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
                            .foregroundColor(.black)
                            
                            .frame(width: 70, height: 20)
                            .background(SharedDesignSystemAsset.Colors.gray5.swiftUIColor.opacity(0.5))
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(SharedDesignSystemAsset.Colors.white.swiftUIColor.opacity(0.5), lineWidth: 1))
                            
                    }
                    
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 14)
            .padding(.horizontal, 23)
        }
        .frame(height: 122)
    }
    
    func CompetitionInfoView() -> some View {
        // 네비게이션
        VStack(alignment: .leading, spacing: 2) {
            Text("오늘 1명이 1칸 이동")
                .font(.pretendard(kind: .heading_md, type: .bold))
                .foregroundStyle(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
            Text("나의 꾸준함 순위는? 1등")
                .font(.pretendard(kind: .body_lg, type: .bold))
                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
        }
        .padding(.top, 28)
        .padding(.bottom, 16)
    }
    
    func BoardView(reader: GeometryProxy, store: StoreOf<HomeFeature>) -> some View {
        // 게임 보드
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<store.competition.board.numberOfRows, id: \.self) { row in
                GridRow {
                    let range: [Int] = (row % 2 == 1)
                    ? Array((0..<store.competition.board.numberOfColumns).reversed())
                    : Array((0..<store.competition.board.numberOfColumns))
                    ForEach(range, id: \.self) { col in
                        let index = col + (row * store.competition.board.numberOfColumns)
                        BlockView(
                            block: store.competition.board.findBlock(by: Position(index: index)),
                            width: calcBlockWidth(reader: reader)
                        )
                    }
                }
            }
        }
        .padding(.top, 4)
    }
}

struct CellView: View {
    let text: String
    let color: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
            Text(text)
                .foregroundColor(.white)
        }
    }
}

struct BlockView: View {
    
    let block: Block?
    
    let width: CGFloat
    
    var body: some View {
        ZStack(alignment: .center) {
            if let block {
                if block.isConquered {
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


extension View {
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct RoundedCorner: Shape {
    
    let radius: CGFloat
    
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
