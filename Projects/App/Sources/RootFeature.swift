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
import DomainUserInterface
import DataRemote
import DataRemoteInterface
import CoreKeychainInterface
import SharedUtilInterface

import FirebaseMessaging

@Reducer
struct RootFeature {

    @Dependency(MissionMemberService.self) var missionMemberService
    @Dependency(UserService.self) var userService
    @Dependency(UserClient.self) var userClient

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
        case didRegisterDeviceToken(Result<Void, Error>)
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
                        print("🚨 \(KeychainProvider.shared.read(.accessToken))")
                        guard KeychainProvider.shared.read(.accessToken) != nil else {
                            await send(.setRootToLogin)
                            return
                        }

                        await send(.didRegisterDeviceToken(Result {
                            try await userClient.registerDeviceToken(userService)
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

            case .didRegisterDeviceToken(.success):
                print("✅ 완성했스요~!")
                return .run { send in
                    await send(.didFetchMissionInfo(Result {
                        try await missionMemberService.getMissionMembersMe()
                    }))
                }

            case .didRegisterDeviceToken(.failure):
                state.destination = .login(LoginFeature.State())
                return .none

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
                if shouldCreateProfile {
                    return .send(.setRootToProfileCreation)
                }
                return .run { send in
                    await send(.didFetchMissionInfo(Result {
                        try await missionMemberService.getMissionMembersMe()
                    }))
                }

            case .destination(.presented(.profileCreation(.delegate(.didCreateProfile)))):
                return .send(.setRootToEntrance(isFirstEntrance: true))

            case .didFetchMissionInfo(.failure):
                KeychainProvider.shared.delete(.accessToken)
                KeychainProvider.shared.delete(.refreshToken)
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
