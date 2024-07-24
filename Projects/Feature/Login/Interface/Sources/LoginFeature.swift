//
//  LoginFeature.swift
//  FeatureLoginInterface
//
//  Created by Miro on 7/24/24.
//

import Foundation

import DomainAuthInterface
import ComposableArchitecture

@Reducer
public struct LoginFeature {

    private let reducer: Reduce<State, Action>

    public init(reducer: Reduce<State, Action>) {
      self.reducer = reducer
    }

    @ObservableState
    public struct State: Equatable {
        var appleLoginInformation: AppleLoginInfomation?
    }

    public enum Action {
        // MARK: User Action
        case appleLoginButtonTapped

        // MARK: Inner SetState Action
        case _setSocialLoginInfo(AppleLoginInfomation)

        // MARK: Delegate Action
        public enum Delegate {
            case completeLogin
        }
        case delegate(Delegate)
    }

    public var body: some ReducerOf<Self> {
      reducer
    }

}
