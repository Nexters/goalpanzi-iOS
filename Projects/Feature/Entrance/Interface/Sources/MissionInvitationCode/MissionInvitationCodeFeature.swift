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

    @ObservableState
    public struct State: Equatable {
        @Presents var invitationConfirm: InvitationConfirmFeature.State?

        var firstInputCode: String = ""
        var secondInputCode: String = ""
        var thirdInputCode: String = ""
        var fourthInputCode: String = ""

        var isInvalid: Bool = false
        var isAllEmpty: Bool = true
        var isAllTexFieldFilled = false

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case confirmButtonTapped
        case backButtonTapped
        case startMission
        case fetchMissionResponse(Result<(InvitationCode, Mission), Error>)
        
        // MARK: Child Action
        case invitationConfirm(PresentationAction<InvitationConfirmFeature.Action>)
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
                    state.isInvalid = false
                } else {
                    state.isAllTexFieldFilled = false
                }
                return .none
            case .confirmButtonTapped:
                let invitationCode = state.firstInputCode + state.secondInputCode + state.thirdInputCode + state.fourthInputCode
                return .run { send in
                    await send(.fetchMissionResponse(
                        Result {
                            try await self.missionClient.fetchMissionInfo(
                                missionService,
                                invitationCode
                            )
                        }
                    ))
                }
            
            case let .fetchMissionResponse(.success(response)):
                state.invitationConfirm = InvitationConfirmFeature.State()
                return .none
                 
            case let .fetchMissionResponse(.failure(error)):
                state.isInvalid = true
                return .none
                
            case .backButtonTapped:
                return .run { _ in
                  await self.dismiss()
                }
            case .invitationConfirm(.presented(.delegate(.didConfirmButtonTapped))):
                return .run { send in
                    await send(.startMission)
                }
            case .startMission:
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$invitationConfirm, action: \.invitationConfirm) {
         InvitationConfirmFeature()
        }
    }
}
