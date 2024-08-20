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
import FeatureSettingInterface
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
        @Shared(.appStorage("isMissionCreated")) var isMissionCreated: Bool = false
        @Presents var destination: RootDestination.State? = nil
        
        init() {}
    }
    
    enum Action {
        case didLoad
        case setRootToLogin
        case setRootToEntrance(isFirstEntrance: Bool)
        case setRootToHome
        case setRootToProfileCreation
        case observeTokenRefreshingFailure
        case didFailTokenRefreshing
        case didFetchMissionInfo(Result<MyMissionInfo, Error>)
        case destination(PresentationAction<RootDestination.Action>)
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
                
            case .setRootToEntrance(let isFirstEntrance):
                state.destination = .entrance(EntranceFeature.State(isFirstEntrance: isFirstEntrance))
                return .none
                
            case .setRootToHome:
                state.destination = .home(HomeFeature.State())
                return .none
                
            case .setRootToProfileCreation:
                state.destination = .profileCreation(PieceCreationFeature.State())
                return .none
                
            case let .didFetchMissionInfo(.success(missionInfo)):
                if missionInfo.missions.isEmpty, state.isMissionCreated == false {
                    return .send(.setRootToEntrance(isFirstEntrance: false))
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
                state.isMissionCreated = false
                return .send(.setRootToLogin)
                
            case let .destination(.presented(.login(.delegate(.didFinishLogin(shouldCreateProfile))))):
                guard shouldCreateProfile else { return .send(.setRootToEntrance(isFirstEntrance: false)) }
                return .send(.setRootToProfileCreation)
                
            case .destination(.presented(.profileCreation(.delegate(.didCreateProfile)))):
                return .send(.setRootToEntrance(isFirstEntrance: true))
                
            case .didFetchMissionInfo(.failure):
                return .none
                
            case .destination(.presented(.entrance(.delegate(.didCreateMission)))):
                state.isMissionCreated = true
                return .send(.setRootToHome)
                
            case .destination(.presented(.entrance(.delegate(.didLogout)))),
                 .destination(.presented(.entrance(.delegate(.didDeleteProfile)))):
                state.isMissionCreated = false
                return .send(.setRootToLogin)
                
            case .destination(.presented(.home(.delegate(.didFinishMission)))),
                 .destination(.presented(.home(.delegate(.didDeleteMission)))):
                state.isMissionCreated = false
                return .send(.setRootToEntrance(isFirstEntrance: false))
                
            case .destination(.presented(.home(.delegate(.didLogout)))),
                 .destination(.presented(.home(.delegate(.didDeleteProfile)))):
                state.isMissionCreated = false
                return .send(.setRootToLogin)
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
