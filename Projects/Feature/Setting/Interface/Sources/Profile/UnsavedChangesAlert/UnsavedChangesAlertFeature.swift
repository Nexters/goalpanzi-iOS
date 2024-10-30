//
//  UnsavedChangesAlertFeature.swift
//  FeatureSetting
//
//  Created by Miro on 10/30/24.
//

import Foundation

import DomainUser
import DomainUserInterface
import DataRemote
import DataRemoteInterface
import CoreKeychainInterface

import ComposableArchitecture

@Reducer
public struct UnsavedChangesAlertFeature: Reducer {

    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case exitButtonTapped
        case cancelButtonTapped

        public enum Delegate {
            case exit
        }

        case delegate(Delegate)
    }

    @Dependency(\.dismiss) var dismiss

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            print(action)
            switch action {
            case .exitButtonTapped:
                return .run { send in
                    await send(.delegate(.exit))
                    await self.dismiss()
                }
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
