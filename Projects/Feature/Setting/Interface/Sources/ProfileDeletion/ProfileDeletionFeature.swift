//
//  ProfileDeletionFeature.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/15/24.
//

import Foundation

import DomainUser
import DomainUserInterface
import DataRemote
import DataRemoteInterface
import CoreKeychainInterface

import ComposableArchitecture

@Reducer
public struct ProfileDeletionFeature: Reducer {
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case deleteProfileButtonTapped
        case cancelButtonTapped
        
        case deleteAccountResponse(Result<Void, Error>)
        
        public enum Delegate {
            case didDeleteProfileSucceed
        }
        
        case delegate(Delegate)

    }
    
    @Dependency(UserClient.self) var userClient
    @Dependency(UserService.self) var userService
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            
            switch action {
            case .deleteProfileButtonTapped:
                return .run { send in
                    await send(.deleteAccountResponse(Result {
                        try await self.userClient.deleteProfile(userService)
                    }))
                }
            case .cancelButtonTapped:
                return .run { _ in
                  await self.dismiss()
                }
            case .deleteAccountResponse(.success(_)):
                KeychainProvider.shared.delete(.accessToken)
                KeychainProvider.shared.delete(.refreshToken)
                return .run { send in
                    await send(.delegate(.didDeleteProfileSucceed))
                    await self.dismiss()
                }
            case .deleteAccountResponse(.failure(let error)):
                print(error)
                return .none
            default:
                return .none
            }
        }
    }
}

