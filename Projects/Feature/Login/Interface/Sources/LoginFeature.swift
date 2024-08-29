//
//  LoginFeature.swift
//  FeatureLoginInterface
//
//  Created by Miro on 7/24/24.
//

import Foundation

import DomainAuth
import DomainAuthInterface
import DataRemote
import DataRemoteInterface
import CoreKeychainInterface

import ComposableArchitecture
import Alamofire

@Reducer
public struct LoginFeature: Reducer {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        
        @Shared(.appStorage("myMemberId")) var myMemberId: Int? = nil
        public init() {}
    }
    
    public enum Action {
        case appleLoginButtonTapped
        case didFinishLogin(Result<SignInInfo, Error>)
        case delegate(Delegate)
    }
    
    public enum Delegate {
        case didFinishLogin(shouldCreateProfile: Bool)
    }
    
    @Dependency(AuthClient.self) var authClient
    @Dependency(AppleAuthService.self) var appleAuthService
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .appleLoginButtonTapped:
                return .run { send in
                    await send(.didFinishLogin(
                        Result {
                            try await authClient.signInWithApple(appleAuthService)
                        }
                    ))
                }
            case let .didFinishLogin(.success(response)):
                KeychainProvider.shared.save(response.accessToken, key: .accessToken)
                KeychainProvider.shared.save(response.refreshToken, key: .refreshToken)
                state.myMemberId = response.memberId
                return .send(.delegate(.didFinishLogin(shouldCreateProfile: !response.isProfileSet)))
            case .didFinishLogin(.failure):
                return .none
            case .delegate:
                return .none
            }
        }
    }
}
