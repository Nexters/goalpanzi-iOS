//
//  MyHistoryFeature.swift
//  MissionMate
//
//  Created by Haeseok Lee on 5/11/25.
//

import Foundation
import ComposableArchitecture
import DomainHistoryInterface
import DataRemoteInterface
import DataRemote

@Reducer
struct MyHistoryFeature {
    
    @Dependency(MissionHistoryService.self) var missionHistoryService
    
    @ObservableState
    struct State {
        var currentPage: Int = 0
        var currentPageSize: Int = 30
        var currentInfo: MissionHistoryInfo = .empty
        var viewState: ViewState = .initial
    }
    
    enum ViewState {
        case initial
        case success(MissionHistoryInfo)
        case failure(Error)
    }
    
    enum Action {
        case onAppear
        case didReachEnd
        case willFetchMyMissionHistoryInfo
        case didFetchMyMissioinHistoryInfo(Result<MissionHistoryInfo, Error>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .onAppear:
                state.viewState = .initial
                state.currentPage = 0
                return .send(.willFetchMyMissionHistoryInfo)
                
            case .didReachEnd:
                guard state.currentInfo.hasNext else { return .none }
                state.currentPage += 1
                return .send(.willFetchMyMissionHistoryInfo)
                
            case .willFetchMyMissionHistoryInfo:
                return .run { [page = state.currentPage, pageSize = state.currentPageSize] send in
                    await send(.didFetchMyMissioinHistoryInfo(Result {
                        try await missionHistoryService.getMissionsHistoriesMe(page, pageSize)
                    }))
                }

            case let .didFetchMyMissioinHistoryInfo(.success(info)):
                state.currentInfo = .init(
                    totalCount: info.totalCount,
                    hasNext: info.hasNext,
                    resultList: state.currentInfo.resultList + info.resultList
                )
                state.viewState = .success(state.currentInfo)
                return .none
                
            case let .didFetchMyMissioinHistoryInfo(.failure(error)):
                state.viewState = .failure(error)
                return .none
            }
        }
    }
}
