//
//  LogoutConfirmFeature.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/15/24.
//

import Foundation

import DomainAuth
import DomainAuthInterface
import DataRemote
import DataRemoteInterface
import CoreKeychainInterface

import ComposableArchitecture

@Reducer
public struct LogoutConfirmFeature: Reducer {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        @Shared(.appStorage("myMemberId")) var myMemberId: Int? = nil
        public init() {}
    }
    
    public enum Action {
        case logoutButtonTapped
        case cancelButtonTapped
        
        case logoutResponse(Result<Void, Error>)
        
        public enum Delegate {
            case didLogoutSucceed
        }
        
        case delegate(Delegate)
    }
    
    @Dependency(AuthClient.self) var authClient
    @Dependency(AppleAuthService.self) var appleAuthService
    @Dependency(\.dismiss) var dismiss

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            
            switch action {
            case .logoutButtonTapped:
                return .run { send in
                    await send(.logoutResponse(Result {
                        try await self.authClient.logout(appleAuthService)
                    }))
                }
            case .logoutResponse(.success(_)):
                KeychainProvider.shared.delete(.accessToken)
                KeychainProvider.shared.delete(.refreshToken)
                state.myMemberId = nil
                return .run { send in
                    await send(.delegate(.didLogoutSucceed))
                    await self.dismiss()
                }
            case .logoutResponse(.failure(let error)):
                print(error)
                return .none
            case .cancelButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }
            default:
                return .none
            }
        }
    }
}
