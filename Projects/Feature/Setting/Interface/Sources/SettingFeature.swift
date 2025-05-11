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
    
    @Reducer
    public enum Destination {
        case logout(LogoutConfirmFeature)
        case profileDeletion(ProfileDeletionFeature)
    }
    
    @Reducer
    public enum Path {
        case updateProfile(UpdateProfileFeature)
        case termsOfUse
        case privacyPolicy
    }
    
    @ObservableState
    public struct State {
        
        var isUpdateSucceed: Bool = false
        var isNavigationPresented = false
        
        @Presents var destination: Destination.State?
        var path: StackState<Path.State> = .init()
        
        public init() {}
    }
    
    public enum Action {
        case navigateUpdateProfileViewTapped
        case navigateTermsOfUseViewTapped
        case navigatePrivacyPolicyViewTapped
        case navigateLogoutViewTapped
        case navigateProfileDeletionViewTapped
        
        case destination(PresentationAction<Destination.Action>)
        case path(StackActionOf<Path>)
        
        // MARK: Child Action
        case delegate(Delegate)
    }
    
    public enum Delegate {
        case didLogout
        case didDeleteProfile
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .navigateUpdateProfileViewTapped:
                state.path.append(.updateProfile(UpdateProfileFeature.State()))
                state.isUpdateSucceed = false
                return .none
            case .navigateTermsOfUseViewTapped:
                state.path.append(.termsOfUse)
                return .none
            case .navigatePrivacyPolicyViewTapped:
                state.path.append(.privacyPolicy)
                return .none
            case .navigateLogoutViewTapped:
                state.destination = .logout(LogoutConfirmFeature.State())
                return .none
            case .navigateProfileDeletionViewTapped:
                state.destination = .profileDeletion(ProfileDeletionFeature.State())
                return .none
            case .path(.element(id: _, action: .updateProfile(.delegate(.didUpdateProfileSucceed)))):
                state.isUpdateSucceed = true
                return .none
            case .destination(.presented(.logout(.delegate(.didLogoutSucceed)))):
                return .send(.delegate(.didLogout))
            case .destination(.presented(.profileDeletion(.delegate(.didDeleteProfileSucceed)))):
                return .send(.delegate(.didDeleteProfile))
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
        .forEach(\.path, action: \.path)
    }
}
