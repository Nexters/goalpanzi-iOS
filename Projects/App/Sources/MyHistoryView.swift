//
//  MyHistoryView.swift
//  MissionMate
//
//  Created by Haeseok Lee on 5/11/25.
//

import SwiftUI
import Kingfisher
import SharedUtil
import SharedDesignSystem
import ComposableArchitecture
import DomainUserInterface

struct MyHistoryView: View {
    
    @Bindable var store: StoreOf<MyHistoryFeature>
    @State var missions: [CompletedMission] = [
        CompletedMission(
            id: UUID(),
            imageURLs: [
                URL(string: "https://dummyimage.com/640x9:16/")!,
                URL(string: "https://dummyimage.com/600x1500/ff5eff/000000")!,
                URL(string: "https://dummyimage.com/600x1500/5eff8e/000000")!,
                URL(string: "https://dummyimage.com/600x1500/f7d600/000000")!,
            ],
            profiles: [.rabbit, .bear, .bird, .cat],
            title: "매일 저녁 1시간 먹기",
            completionCounter: 8,
            totalCounter: 10,
            rank: 1,
            startDate: Date.now,
            endDate: Date.now + 100
        ),
        CompletedMission(
            id: UUID(),
            imageURLs: [
                URL(string: "https://dummyimage.com/640x9:16/")!,
                URL(string: "https://dummyimage.com/600x1500/f7d600/000000")!,
                URL(string: "https://dummyimage.com/640x9:16/")!,
            ],
            profiles: [.rabbit, .bear, .bird, .cat],
            title: "매일 저녁 2시간 먹기",
            completionCounter: 1,
            totalCounter: 10,
            rank: 2,
            startDate: Date.now,
            endDate: Date.now + 100
        )
    ]
    
    init(store: StoreOf<MyHistoryFeature>) {
        self.store = store
    }
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("내기록")
                    .foregroundStyle(Color.mmGray1)
                    .font(.pretendard(kind: .heading_sm, type: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.mmWhite)
            .padding(.horizontal, 24)
            .padding(.top, 7)
            .padding(.bottom, 16)
            HStack(spacing: 0) {
                HStack(spacing: 4) {
                    Text("완료 미션")
                        .foregroundStyle(Color.mmGray1)
                        .font(.pretendard(kind: .title_lg, type: .bold))
                    Text("(\(missions.count))")
                        .foregroundStyle(Color.mmGray3)
                        .font(.pretendard(kind: .body_lg, type: .regular))
                }
                Text("최신 종료순")
                    .foregroundStyle(Color.mmGray3)
                    .font(.pretendard(kind: .body_lg, type: .regular))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            GeometryReader { geometry in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(missions) { mission in
                            CardView(mission: mission, size: geometry.size)
                        }
                    }
                }
            }
        }
    }
}

extension MyHistoryView {
    
    struct CardView: View {
        
        let mission: CompletedMission
        let size: CGSize
        @State private var currentIndex = 0
        
        @ViewBuilder
        var body: some View {
            ZStack(alignment: .bottom) {
                TimelineView(.periodic(from: .now, by: 2.5)) { context in
                    KFImage(mission.imageURLs[currentIndex])
                        .resizable()
                        .placeholder({ Color.white })
                        .scaledToFill()
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            )
                        )
                        .id(currentIndex)
                        .animation(.linear(duration: 0.5), value: currentIndex)
                        .onChange(of: Int(context.date.timeIntervalSinceReferenceDate) % mission.imageURLs.count) { old, new in
                            currentIndex = new
                        }
                }
                
                VStack() {
                    VStack(spacing: 8) {
                        HStack(alignment: .bottom, spacing: 12) {
                            VStack(alignment: .leading, spacing: 2) {
                                Color.red
                                    .frame(width: 100, height: 32)
                                    .padding(.bottom, 2)
                                
                                Text(mission.title)
                                    .foregroundStyle(Color.mmGray1)
                                    .font(.pretendard(kind: .title_lg, type: .bold))
                                    .frame(maxHeight: .infinity, alignment: .leading)
                                HStack(spacing: 10) {
                                    Text(mission.totalRankDescription)
                                        .foregroundStyle(Color.mmOrange)
                                        .font(.pretendard(kind: .body_lg, type: .bold))
                                    Text(mission.rankDescription)
                                        .foregroundStyle(Color.mmGray1)
                                        .font(.pretendard(kind: .body_lg, type: .regular))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Color.red
                                .frame(width: 63, height: 59)
                        }
                        Text(mission.dateString)
                            .foregroundStyle(Color.mmGray3)
                            .font(.pretendard(kind: .body_md, type: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
                .frame(width: size.width)
                .frame(height: 152)
                .background(.ultraThinMaterial, in: Rectangle())
            }
            .frame(width: size.width)
            .frame(height: size.height)
        }
    }
}

extension MyHistoryView {
    
    struct CharacterGroup: View {
        
        let characters: [Character]
        var displayCharacters: [Character] { Array(characters.prefix(3)) }
        
        @ViewBuilder
        var body: some View {
            ForEach(Array(displayCharacters.enumerated()), id: \.offset) { _, character in
                
            }
        }
        
    }
}

struct CompletedMission: Identifiable {
    let id: UUID
    let imageURLs: [URL]
    let profiles: [Character]
    let title: String
    let completionCounter: Int
    let totalCounter: Int
    let rank: Int
    let startDate: Date
    let endDate: Date
    
    typealias ProfileCharacterName = String
}

extension CompletedMission {
    
    var rankDescription: String {
        "최종\(rank)등이에요"
    }
    
    var totalRankDescription: String {
        "\(completionCounter)/\(totalCounter)칸"
    }
    
    var dateString: String {
        "\(DateFormatter.yearMonthDayFormatter.string(from: startDate))~\(DateFormatter.yearMonthDayFormatter.string(from: endDate))"
    }
}
