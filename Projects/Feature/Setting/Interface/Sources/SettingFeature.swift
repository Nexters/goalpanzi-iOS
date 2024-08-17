//
//  SettingFeature.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/14/24.
//

import Foundation

import DomainUserInterface
import DomainUser
import DataRemote
import DataRemoteInterface

import ComposableArchitecture

@Reducer
public struct SettingFeature: Reducer {
    
    @Dependency(\.dismiss) var dismiss
    
    public init() {}
    
    @Reducer(state: .equatable)
    public enum Destination {
        case updateProfile(UpdateProfileFeature)
        case termsOfUse
        case privacyPolicy
        case logout(LogoutConfirmFeature)
        case profileDeletion(ProfileDeletionFeature)
    }
    
    @ObservableState
    public struct State: Equatable {
        @Presents var destination: Destination.State?
        var isNavigationPresented = false
        
        public init() {}
    }
    
    public enum Action {
        case destination(PresentationAction<Destination.Action>)
        
        case backButtonTapped
        case navigateUpdateProfileViewTapped
        case navigateTermsOfUseViewTapped
        case navigatePrivacyPolicyViewTapped
        case navigateLogoutViewTapped
        case navigateProfileDeletionViewTapped
        
        // MARK: Child Action
        case logoutSucceed(PresentationAction<LogoutConfirmFeature.Action>)
        case deleteProfileSucceed(PresentationAction<ProfileDeletionFeature.Action>)
        case delegate(Delegate)
    }
    
    public enum Delegate {
        case didLogout
        case didDeleteProfile
    }
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            
            switch action {
            case .backButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }
            case .navigateUpdateProfileViewTapped:
                state.destination = .updateProfile(UpdateProfileFeature.State())
                return .none
            case .navigateTermsOfUseViewTapped:
                state.destination = .termsOfUse
                return .none
            case .navigatePrivacyPolicyViewTapped:
                state.destination = .privacyPolicy
                return .none
            case .navigateLogoutViewTapped:
                state.destination = .logout(LogoutConfirmFeature.State())
                return .none
            case .navigateProfileDeletionViewTapped:
                state.destination = .profileDeletion(ProfileDeletionFeature.State())
                return .none
            case .logoutSucceed(.presented(.delegate(.didLogoutSucceed))):
                return .send(.delegate(.didLogout))
            case .deleteProfileSucceed(.presented(.delegate(.didDeleteProfileSucceed))):
                return .send(.delegate(.didDeleteProfile))
            case .destination(_):
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
