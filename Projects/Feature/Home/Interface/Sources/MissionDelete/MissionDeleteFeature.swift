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
        case error(Error)
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
                    do {
                        _ = try await missionService.deleteMissions(missionId)
                        await self.dismiss()
                    } catch {
                        await send(.error(error))
                    }
                    
                }
            case let .error(error):
                return .none
            }
        }
    }
    
    public init() {}
}

