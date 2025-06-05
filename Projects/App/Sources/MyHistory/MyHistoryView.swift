//
//  MyHistoryView.swift
//  MissionMate
//
//  Created by Haeseok Lee on 5/11/25.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture
import DomainHistoryInterface
import DomainUserInterface

struct MyHistoryView: View {
    
    @Bindable var store: StoreOf<MyHistoryFeature>
    
    init(store: StoreOf<MyHistoryFeature>) {
        self.store = store
    }
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            ContentView(store: store)
        }
    }
}

extension MyHistoryView {
    
    struct HeaderView: View {
        
        @ViewBuilder
        var body: some View {
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
        }
    }
    
    struct ContentView: View {
        
        @Bindable var store: StoreOf<MyHistoryFeature>
        
        @ViewBuilder
        var body: some View {
            switch store.viewState {
            case .initial:
                GeometryReader { geometry in
                    LoadingView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .task {
                            await store.send(.onAppear).finish()
                        }
                }
            case .failure:
                GeometryReader { geometry in
                    FailureView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            case let .success(info):
                VStack(spacing: 0) {
                    header(totalCount: info.totalCount)
                    content(histories: info.resultList, hasNext: info.hasNext)
                }
            }
        }
        
        @ViewBuilder
        func header(totalCount: Int) -> some View {
            HStack(spacing: 0) {
                HStack(spacing: 4) {
                    Text("완료 미션")
                        .foregroundStyle(Color.mmGray1)
                        .font(.pretendard(kind: .title_lg, type: .bold))
                    Text("(\(totalCount))")
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
        }
        
        @ViewBuilder
        func content(histories: [MissionHistoryInfo.History], hasNext: Bool) -> some View {
            GeometryReader { geometry in
                ScrollView {
                    if histories.isEmpty {
                        VStack(spacing: 0) {
                            Image(uiImage: SharedDesignSystemAsset.Images.emptyHistoryInfoToolTip.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Image(uiImage:SharedDesignSystemAsset.Images.basicRabbit.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 35)
                        }
                        .padding(.horizontal, 75)
                        .padding(.top, (geometry.size.height - 350) / 2)
                    } else {
                        LazyVStack(spacing: 0) {
                            ForEach(histories) { history in
                                CardView(history: history, size: geometry.size)
                            }
                            FooterView(size: geometry.size)
                                .isHidden(!hasNext, remove: true)
                                .task {
                                    await store.send(.didReachEnd).finish()
                                }
                        }
                    }
                }
                .refreshable {
                    await store.send(.didRefresh).finish()
                }
            }
        }
    }
}

extension MissionHistoryInfo.History {
    
    var rankDescription: String {
        "최종\(rank)등이에요"
    }
    
    var totalRankDescription: String {
        "\(memberCount)/\(rank)칸"
    }
    
    var dateString: String {
        "\(DateFormatter.yearMonthDayFormatter.string(from: missionStartDate))~\(DateFormatter.yearMonthDayFormatter.string(from: missionEndDate))"
    }
}

extension MissionHistoryInfo.History {
    
    var rankImage: Image {
        switch rank {
        case 1:
            return SharedDesignSystemAsset.Images.firstPrize.swiftUIImage
        case 2:
            return SharedDesignSystemAsset.Images.secondPrize.swiftUIImage
        case 3:
            return SharedDesignSystemAsset.Images.thirdPrize.swiftUIImage
        default:
            return SharedDesignSystemAsset.Images.prize.swiftUIImage
        }
    }
}
