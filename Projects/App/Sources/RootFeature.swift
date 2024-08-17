//
//  RootFeature.swift
//  Feature
//
//  Created by Haeseok Lee on 7/28/24.
//

import Foundation
import ComposableArchitecture
import FeatureLoginInterface
import FeatureEntranceInterface
import FeatureHomeInterface
import FeaturePieceCreationInterface
import DomainPlayerInterface
import DataRemote
import DataRemoteInterface
import CoreKeychainInterface
import SharedUtilInterface

@Reducer
struct RootFeature {
    
    @Dependency(MissionMemberService.self) var missionMemberService
    
    @ObservableState
    struct State {
        @Presents var destination: RootDestination.State? = nil
        var path: StackState<RootPath.State> = .init()
        
        init() {}
    }
    
    enum Action {
        case didLoad
        case setRootToLogin
        case setRootToEntrance
        case setRootToHome
        case setRootToProfileCreation
        case observeTokenRefreshingFailure
        case didFailTokenRefreshing
        case pushLogin
        case didFetchMissionInfo(Result<MyMissionInfo, Error>)
        case destination(PresentationAction<RootDestination.Action>)
        case path(StackActionOf<RootPath>)
    }
    
    enum CancelID {
        case notification
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didLoad:
                return .concatenate(
                    .run { send in
                        guard KeychainProvider.shared.read(.accessToken) != nil else {
                            await send(.setRootToLogin)
                            return
                        }
                        await send(.didFetchMissionInfo(Result {
                            try await missionMemberService.getMissionMembersMe()
                        }))
                    },
                    .send(.observeTokenRefreshingFailure)
                )
                
            case .setRootToLogin:
                state.destination = .login(LoginFeature.State())
                return .none
                
            case .setRootToEntrance:
                state.destination = .entrance(EntranceFeature.State())
                return .none
                
            case .setRootToHome:
                state.destination = .home(HomeFeature.State())
                return .none
                
            case .setRootToProfileCreation:
                state.destination = .profileCreation(PieceCreationFeature.State())
                return .none
                
            case .pushLogin:
                state.path.append(.login(LoginFeature.State()))
                return .none
                
            case let .didFetchMissionInfo(.success(missionInfo)):
                if missionInfo.missions.isEmpty {
                    return .send(.didFailTokenRefreshing)
                }
                return .send(.setRootToHome)
                
            case .observeTokenRefreshingFailure:
                return .run { send in
                    for await _ in NotificationCenter.default.notifications(named: .didFailTokenRefreshing) {
                        await send(.didFailTokenRefreshing)
                    }
                }
                .cancellable(id: CancelID.notification)
                
            case .didFailTokenRefreshing:
                return .send(.setRootToLogin)
                
            case let .destination(.presented(.login(.delegate(.didFinishLogin(shouldCreateProfile))))):
                guard shouldCreateProfile else { return .send(.setRootToEntrance) }
                return .send(.setRootToProfileCreation)
                
            case .destination(.presented(.profileCreation(.delegate(.didCreateProfile)))):
                return .send(.setRootToEntrance)
                
            case .didFetchMissionInfo(.failure):
                return .none
                
            case .destination(.presented(.entrance(.delegate(.didCreateMission)))):
                return .send(.setRootToHome)
                
            case .destination:
                return .none
                
            case .path:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
        .forEach(\.path, action: \.path)
    }
}
