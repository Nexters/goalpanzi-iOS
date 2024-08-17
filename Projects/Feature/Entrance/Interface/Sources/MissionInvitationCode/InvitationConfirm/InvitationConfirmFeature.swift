//
//  InvitationConfirmFeature.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/9/24.
//

import Foundation

import DomainMissionInterface
import DomainMission
import DataRemote
import DataRemoteInterface

import ComposableArchitecture

@Reducer
public struct InvitationConfirmFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {
        var mission: Mission
        var authenticationDays: String
        var missionTitle: String
        var missionDuration: String
        var missionWeekDay: String
        var missionTimeOfDay: String
        var invitationCode: String

        public init(mission: Mission) {
            self.mission = mission
            self.authenticationDays = "\(mission.verificationDays)"
            self.missionTitle = mission.description
            self.missionDuration = mission.startDate.formattedString(dateFormat: .yearMonthDate) + "~" + mission.endDate.formattedString(dateFormat: .yearMonthDate)
            self.missionWeekDay = mission.verificationWeekDays.map { $0.koreanName }.joined(separator: "/")
            self.missionTimeOfDay = mission.timeOfDay.description
            self.invitationCode = mission.invitationCode
        }
    }
    

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case confirmButtonTapped
        case denyButtonTapped
        
        case joinCompetitionResponse(Result<Void, Error>)
        case fetchMissionResponse(Result<Mission, Error>)
        
        public enum Delegate {
            case didConfirmButtonTapped
        }
        
        case delegate(Delegate)
    }
    
    @Dependency(MissionClient.self) var missionClient
    @Dependency(MissionService.self) var missionService
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .confirmButtonTapped:
                return .run { send in
                    await send(.joinCompetitionResponse(
                        Result {
                            try await self.missionClient.joinCompetition(
                                missionService,
                                ""
                            )
                        }
                    ))
                }
            case .denyButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }
                
            case .joinCompetitionResponse(.success):
                return .run { send in
                    await send(.delegate(.didConfirmButtonTapped))
                }

            case let .joinCompetitionResponse(.failure(error)):
                return .none

            default:
                return .none
            }
        }
    }

}
