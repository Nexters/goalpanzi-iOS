//
//  AccountDeletionFeature.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/15/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct AccountDeletionFeature: Reducer {
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case logoutButtonTapped
        case cancelButtonTapped
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            
            switch action {
            case .logoutButtonTapped:
                return .none
            case .cancelButtonTapped:
                return .run { _ in
                  await self.dismiss()
                }
            }
        }
    }
}
