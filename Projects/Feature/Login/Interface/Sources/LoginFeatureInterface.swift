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

@Reducer
public struct LoginFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {
        var appleLoginInformation: AppleLoginInfomation?
        public init() {}
    }

    public enum Action {
        // MARK: User Action
        case appleLoginButtonTapped

        // MARK: Inner SetState Action
        case _setSocialLoginInfo(AppleLoginInfomation)
    }

    @Dependency(\.socialLoginClient) var socialLoginClient

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .appleLoginButtonTapped:
                return .run { send in
                    do {
                        let information = try await socialLoginClient.appleLogin()
                        await self.handle(information, send: send)
                    } catch {
                        print("애플 로그인 에러")
                    }
                }

            case ._setSocialLoginInfo(let information):
                state.appleLoginInformation = information
                return .none
            }
        }
    }

    private func handle(_ information: AppleLoginInfomation, send: Send<LoginFeature.Action>) async {
        await send(._setSocialLoginInfo(information))
        // 여기서 키체인 설정하기
        // 서버와 통신하기
    }
}
