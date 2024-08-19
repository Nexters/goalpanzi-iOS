//
//  MissionInvitationCodeFeature.swift
//  FeatureEntrance
//
//  Created by Miro on 8/8/24.
//

import Foundation

import DomainMissionInterface
import DomainMission
import DataRemote
import DataRemoteInterface

import ComposableArchitecture

@Reducer
public struct MissionInvitationCodeFeature: Reducer {

    public init() {}
    
    
    @Reducer
    public enum Destination {
        case invitationConfirm(InvitationConfirmFeature)
    }


    @ObservableState
    public struct State {
        @Presents var destination: Destination.State?

        var firstInputCode: String = ""
        var secondInputCode: String = ""
        var thirdInputCode: String = ""
        var fourthInputCode: String = ""
        
        var toastErrorMessage: String = ""
        
        var isUnavailableInvitation: Bool = false
        var isInvalidInvitationCode: Bool = false
        var isAllEmpty: Bool = true
        var isAllTexFieldFilled: Bool = false

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case confirmButtonTapped
        case backButtonTapped
        case startMission
        
        case checkJoinableMissionResponse(Result<Mission, Error>)
        
        // MARK: Child Action
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Dependency(MissionClient.self) var missionClient
    @Dependency(MissionService.self) var missionService
    @Dependency(\.dismiss) var dismiss

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .binding(\.firstInputCode):
                state.isAllEmpty = (state.firstInputCode == "") ? true : false
                return .none
            case .binding(\.fourthInputCode):
                if state.fourthInputCode != "" {
                    state.isAllTexFieldFilled = true
                    state.isInvalidInvitationCode = false
                } else {
                    state.isAllTexFieldFilled = false
                }
                return .none
            case .confirmButtonTapped:
                let invitationCode = state.firstInputCode + state.secondInputCode + state.thirdInputCode + state.fourthInputCode
                return .run { send in
                    await send(.checkJoinableMissionResponse(
                        Result {
                            try await self.missionClient.checkJoinableMission(
                                missionService,
                                invitationCode
                            )
                        }
                    ))
                }
            case let .checkJoinableMissionResponse(.success(response)):
                state.destination = .invitationConfirm(InvitationConfirmFeature.State(mission: response))
                return .none
                 
            case let .checkJoinableMissionResponse(.failure(error)):
                guard let error = error as? MissionClientError else { return .none }
                handleInvitationCode(with: error, state: &state)
                return .none
                
            case .backButtonTapped:
                return .run { _ in
                  await self.dismiss()
                }
            case .destination(.presented(.invitationConfirm(.delegate(.didConfirmButtonTapped)))):
                return .send(.startMission)
            case .startMission:
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension MissionInvitationCodeFeature {
    private func handleInvitationCode(with error: MissionClientError, state: inout State) {
        switch error {
        case .notFoundMission:
            state.isInvalidInvitationCode = true
        case .exceedMaxPersonnel:
            state.toastErrorMessage = "최대 인원으로 이미 가득차서 참여할 수 없어요"
            state.isUnavailableInvitation = true
        case .cannotJoinMission:
            state.toastErrorMessage = "이미 시작된 경쟁이라 참여할 수 없어요"
            state.isUnavailableInvitation = true
        }
    }
}
