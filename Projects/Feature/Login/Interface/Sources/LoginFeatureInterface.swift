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

    @Dependency(\.socialLoginAuth) var socialLoginAuth
    @Dependency(\.authClient) var authClient

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .appleLoginButtonTapped:
                return .run { send in
                    do {
                        let information = try await socialLoginAuth.appleLogin()
                        await self.handle(information, send: send)
                    } catch {
                        print("애플 로그인 에러")
                    }
                }
            }
        }
    }

    private func handle(_ information: AppleLoginInfomation, send: Send<LoginFeature.Action>) async {
        do {
            let response: SignInResponseDTO = try await authClient.signIn(.init(identityToken: information.identityToken))
            print(response)
        } catch {
            print("error: \(error)")
        }
    }
}
