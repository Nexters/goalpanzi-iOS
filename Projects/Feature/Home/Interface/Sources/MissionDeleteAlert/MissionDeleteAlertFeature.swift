//
//  MissionDeletAlertFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/5/24.
//

import Foundation
import DataRemote
import DataRemoteInterface
import ComposableArchitecture

@Reducer
public struct MissionDeleteAlertFeature {
    
    @Dependency(MissionService.self) var missionService
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        
        public let missionId: Int
        
        public init(missionId: Int) {
            self.missionId = missionId
        }
    }
    
    public enum Action {
        case didTapConfirmButton
        case didDeleteMission(Result<Void, Error>)
        case delegate(Delegate)
    }
    
    public enum Delegate {
        case didDeleteMission
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapConfirmButton:
                return .run { [missionId = state.missionId] send in
                    await send(.didDeleteMission(
                        Result { _ = try await missionService.deleteMissions(missionId) }
                    ))
                }
            case .didDeleteMission(.success):
                return .concatenate(
                    .send(.delegate(.didDeleteMission)),
                    .run { _ in
                        await self.dismiss()
                    }
                )
                
            case .didDeleteMission(.failure):
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
    
    public init() {}
}

