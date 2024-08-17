//
//  MissionDeletFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/5/24.
//

import Foundation
import DataRemote
import DataRemoteInterface
import ComposableArchitecture

@Reducer
public struct MissionDeleteFeature {
    
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
        case didTapCloseButton
        case didDeleteMission(Result<Void, Error>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapCloseButton:
                return .run { _ in
                    await self.dismiss()
                }
                
            case .didTapConfirmButton:
                return .run { [missionId = state.missionId] send in
                    await send(.didDeleteMission(
                        Result { _ = try await missionService.deleteMissions(missionId) }
                    ))
                }
            case .didDeleteMission(.success):
                return .run { _ in
                    await self.dismiss()
                }
            case .didDeleteMission(.failure):
                return .none
            }
        }
    }
    
    public init() {}
}

