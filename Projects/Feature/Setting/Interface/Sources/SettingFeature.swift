//
//  SettingFeature.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/14/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct SettingFeature: Reducer {
    
    public init() {}
    
    @Reducer(state: .equatable)
    public enum Destination {
        case updateProfile
        case termsOfUse
        case privacyPolicy
        case logout
        case accountDelete
    }
    
    
    @ObservableState
    public struct State: Equatable {
        @Presents var destination: Destination.State?
        
        public init() {}
    }
    
    public enum Action {
        case destination(PresentationAction<Destination.Action>)
        
        case backButtonTapped
        case navigateUpdateProfileViewTapped
        case navigateTermsOfUseViewTapped
        case navigatePrivacyPolicyViewTapped
        case navigateLogoutViewTapped
        case navigateAccountDeleteViewTapped
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            
            switch action {
            case .backButtonTapped:
                return .none
            case .navigateUpdateProfileViewTapped:
                return .none
            case .navigateTermsOfUseViewTapped:
                state.destination = .termsOfUse
                return .none
            case .navigatePrivacyPolicyViewTapped:
                state.destination = .privacyPolicy
                return .none
            case .navigateLogoutViewTapped:
                return .none
            case .navigateAccountDeleteViewTapped:
                return .none
            case .destination(_):
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
