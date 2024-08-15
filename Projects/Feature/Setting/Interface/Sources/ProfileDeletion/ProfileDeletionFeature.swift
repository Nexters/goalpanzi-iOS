//
//  ProfileDeletionFeature.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/15/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ProfileDeletionFeature: Reducer {
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case deleteAccountButtonTapped
        case cancelButtonTapped
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            
            switch action {
            case .deleteAccountButtonTapped:
                return .none
            case .cancelButtonTapped:
                return .run { _ in
                  await self.dismiss()
                }
            }
        }
    }
}

