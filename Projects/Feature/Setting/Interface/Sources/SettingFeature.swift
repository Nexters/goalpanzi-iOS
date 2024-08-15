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
        case navigateUpdateProfileViewTapped(isPresented: Bool)
        case navigateTermsOfUseViewTapped
        case navigatePrivacyPolicyViewTapped
        case navigateLogoutViewTapped
        case navigateProfileDeletionViewTapped
        
        case checkProfileResponse(Result<UserProfile, Error>)
        
        // MARK: Child Action
        case logoutSucceed(PresentationAction<LogoutConfirmFeature.Action>)
        case deleteProfileSucceed(PresentationAction<ProfileDeletionFeature.Action>)
    }
    
    @Dependency(UserClient.self) var userClient
    @Dependency(UserService.self) var userService
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            
            switch action {
            case .backButtonTapped:
                return .none
            case .navigateUpdateProfileViewTapped(isPresented: true):
                state.isNavigationPresented = true
                return .run { send in
                    await send(.checkProfileResponse(
                        Result {
                            try await self.userClient.checkProfile(userService)
                        }
                    ))
                }
                
            case .checkProfileResponse(.success(let userProfile)):
                state.destination = .updateProfile(UpdateProfileFeature.State(userProfile: userProfile))
                return .none
                
            case .checkProfileResponse(.failure(let error)):
                print("🚨 에러 발생!! \(error)")
                return .none
            case .navigateUpdateProfileViewTapped(isPresented: false):
                state.isNavigationPresented = false
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
                // TODO: 여기서 Home으로 알려서 바로 로그인 화면으로 옮기기!
                return .none
            case .deleteProfileSucceed(.presented(.delegate(.didDeleteProfileSucceed))):
                // TODO: 여기서 Home으로 알려서 바로 로그인 화면으로 옮기기!
                return .none
                
            case .destination(_):
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
