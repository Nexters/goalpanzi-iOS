//
//  LoginFeature.swift
//  FeatureLoginInterface
//
//  Created by Miro on 7/24/24.
//

import Foundation

import DomainAuthInterface
import DomainAuth
import ComposableArchitecture
import Alamofire
import DataRemote

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
                        print(response)
                    } catch {
                        print("애플 로그인 에러")
                    }
                }
            }
        }
    }
}
