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
        public init() {}
    }
    
    public enum Action {
        // MARK: User Action
        case appleLoginButtonTapped
    }
    
    @Dependency(AuthClient.self) var authClient
    @Dependency(AppleAuthService.self) var appleAuthService
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .appleLoginButtonTapped:
                return .run { send in
                    do {
                        let response = try await authClient.signInWithApple(appleAuthService)

                        KeychainProvider.shared.save(response.accessToken, key: .accessToken)
                        KeychainProvider.shared.save(response.refreshToken, key: .refreshToken)
                    } catch {
                        print(error)
                        print("애플 로그인 에러")
                    }
                }
            }
        }
    }
}
