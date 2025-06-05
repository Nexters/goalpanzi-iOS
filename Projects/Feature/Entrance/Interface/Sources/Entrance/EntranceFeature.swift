//
//  EntranceFeature.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/5/24.
//

import Foundation

import DomainUser
import DomainUserInterface
import DataRemote
import DataRemoteInterface

import ComposableArchitecture

@Reducer
public struct EntranceFeature: Reducer {
    
    public init() {}
    
    @Reducer
    public enum Path {
        // 🚨 미션 생성
        case missionContentSetting(MissionContentSettingFeature)
        case missionDurationSetting(MissionDurationSettingFeature)
        case missionAuthTimeSetting(MissionAuthTimeSettingFeature)
        
        // 🚨 초대코드 검증
        case missionInputInviationCode(MissionInvitationCodeFeature)
    }
    
    @ObservableState
    public struct State {
        @Presents var pieceCreationCompleted: PieceCreationCompletedFeature.State?
        var isFirstEntrance: Bool
        
        var path = StackState<Path.State>()
        @Shared var missionCreationData: MissionCreationData
        
        var isCheckingProfile: Bool = true
        var userProfileCharacter: Character = .rabbit
        
        public init(isFirstEntrance: Bool) {
            self._missionCreationData = Shared(MissionCreationData())
            self.isFirstEntrance = isFirstEntrance
        }
        
        public mutating func update(isFirstEntrance: Bool) {
            self.isFirstEntrance = isFirstEntrance
        }
    }
    
    public enum Action {
        case path(StackActionOf<Path>)
        case delegate(Delegate)
        case pieceCreationCompleted(PresentationAction<PieceCreationCompletedFeature.Action>)

        case createMissionButtonTapped
        case enterInvitationCodeButtonTapped
        
        case onAppear
        
        case checkProfileResponse(Result<UserProfile, Error>)
    }
    
    public enum Delegate {
        case didCreateMission
    }
    
    @Dependency(UserClient.self) var userClient
    @Dependency(UserService.self) var userService
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.checkProfileResponse(
                        Result { try await self.userClient.checkProfile(userService) }
                    ))
                }
            case .checkProfileResponse(.success(let userProfile)):
                state.isCheckingProfile = false
                state.userProfileCharacter = userProfile.character
                
                if state.isFirstEntrance {
                    state.pieceCreationCompleted = PieceCreationCompletedFeature.State(userProfile: userProfile)
                    state.isFirstEntrance = false
                }
                return .none
            case .checkProfileResponse(.failure(let error)):
                print("🚨 에러 발생!! \(error)")
                return .none
            case .pieceCreationCompleted:
                return .none
            case .createMissionButtonTapped:
                state.path.append(.missionContentSetting(MissionContentSettingFeature.State( missionCreationData: state.$missionCreationData)))
                return .none
            case .enterInvitationCodeButtonTapped:
                state.path.append(.missionInputInviationCode(MissionInvitationCodeFeature.State()))
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .missionContentSetting(.nextButtonTapped)):
                    state.path.append(.missionDurationSetting(MissionDurationSettingFeature.State(missionCreationData: state.$missionCreationData)))
                    return .none
                    
                case .element(id: _, action: .missionDurationSetting(.nextButtonTapped)):
                    state.path.append(.missionAuthTimeSetting(MissionAuthTimeSettingFeature.State(missionCreationData: state.$missionCreationData)))
                    return .none
                    
                case .element(id: _, action: .missionAuthTimeSetting(.startMission)):
                    return .send(.delegate(.didCreateMission))
                    
                case .element(id: _, action: .missionInputInviationCode(.startMission)):
                    return .send(.delegate(.didCreateMission))
                    
                default:
                    return .none
                }
            case .delegate:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$pieceCreationCompleted, action: \.pieceCreationCompleted) {
          PieceCreationCompletedFeature()
        }
    }
}
