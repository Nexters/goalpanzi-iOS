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
        let initialPage: Int = 0
        let pageSize: Int = 30
        var nextPage: Int = 0
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
        case didRefresh
        case didFetchMyMissionHistoryInfoAndAppend(Result<MissionHistoryInfo, Error>)
        case didFetchMyMissionHistoryInfoAndReplace(Result<MissionHistoryInfo, Error>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.viewState = .initial
                return .run { [page = state.initialPage, pageSize = state.pageSize] send in
                    await send(.didFetchMyMissionHistoryInfoAndReplace(Result {
                        try await missionHistoryService.getMissionsHistoriesMe(page, pageSize)
                    }))
                }
                
            case .didRefresh:
                return .run { [page = state.initialPage, pageSize = state.pageSize] send in
                    await send(.didFetchMyMissionHistoryInfoAndReplace(Result {
                        try await missionHistoryService.getMissionsHistoriesMe(page, pageSize)
                    }))
                }
                
            case .didReachEnd:
                guard state.currentInfo.hasNext else { return .none }
                return .run { [page = state.nextPage, pageSize = state.pageSize] send in
                    await send(.didFetchMyMissionHistoryInfoAndAppend(Result {
                        try await missionHistoryService.getMissionsHistoriesMe(page, pageSize)
                    }))
                }
                
            case let .didFetchMyMissionHistoryInfoAndAppend(.success(info)):
                state.currentInfo = .init(
                    totalCount: info.totalCount,
                    hasNext: info.hasNext,
                    resultList: state.currentInfo.resultList + info.resultList
                )
                state.nextPage += 1
                state.viewState = .success(state.currentInfo)
                return .none
                
            case let .didFetchMyMissionHistoryInfoAndReplace(.success(info)):
                state.currentInfo = .init(
                    totalCount: info.totalCount,
                    hasNext: info.hasNext,
                    resultList: info.resultList
                )
                state.nextPage = state.initialPage + 1
                state.viewState = .success(state.currentInfo)
                return .none
                
            case let .didFetchMyMissionHistoryInfoAndAppend(.failure(error)):
                state.viewState = .failure(error)
                return .none
                
            case let .didFetchMyMissionHistoryInfoAndReplace(.failure(error)):
                state.viewState = .failure(error)
                return .none
            }
        }
    }
}
