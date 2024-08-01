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
        VStack(spacing: 20) {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    GeometryReader { reader in
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 4) {
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
                                // 게임 보드
                                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                                    ForEach(0..<store.numberOfRows, id: \.self) { row in
                                        GridRow {
                                            let range: [Int] = (row % 2 == 1)
                                                ? Array((0..<store.numberOfColumns).reversed())
                                                : Array((0..<store.numberOfColumns))
                                            ForEach(range, id: \.self) { col in
                                                let index = col + (row * store.numberOfColumns)
                                                BlockView(
                                                    block: store.mission.board.findBlock(by: Position(index: index)), 
                                                    totalBlockCount: store.mission.board.totalBlockCount,
                                                    numberOfColumns: store.mission.board.numberOfColumns,
                                                    width: calcBlockWidth(reader: reader)
                                                )
                                            }
                                        }
                                    }
                                }
                                .padding(.top, 4)
                            }
                            .padding(.top, 167)
                            .padding(.horizontal, horizontalPadding)
                            .padding(.bottom, 142)
                        }
                    }
                    
                    
                    VStack(spacing: 0) {
                        HStack(alignment: .center) {
                            Image(systemName: "flag.fill")
                                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                            Spacer()
                            Text("매일 유산소 1시간")
                                .font(.headline)
                            Spacer()
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                        }
                        .padding(.horizontal, 24)
                        .frame(height: 45)
                        
                        // 캐릭터 리스트 섹션
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(store.mission.competition.players) { player in
                                    VStack {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                        Text("\(player.name)")
                                            .font(.caption)
                                    }
                                }
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 14)
                            .padding(.horizontal, 23)
                        }
                        .frame(height: 122)
                    }
                    .background(.thinMaterial)
                }
                
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
        }
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
    
    let totalBlockCount: Int
    
    let numberOfColumns: Int
    
    var title: String {
        guard let block else { return "" }
        switch block.kind(numberOfColumns: numberOfColumns, totalBlockCount: totalBlockCount) {
        case .square:
            return "⏹️"
        case .firstQuadrant:
            return "↘️"
        case .secondQuadrant:
            return "↙️"
        case .thirdQuadrant:
            return "↘️"
        case .fourthQuardrant:
            return "↙️"
        }
    }
    
    let width: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: width, height: width)
            Text(title)
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
