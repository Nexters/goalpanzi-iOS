//
//  MissionInfoFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/8/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MissionInfoFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        
        public let missionId: Int
        
        public let totalBlockCount: Int
        
        public var infos: [Info]
        
        @Presents var destination: Destination.State?
        
        public init(missionId: Int, totalBlockCount: Int, infos: [Info]) {
            self.missionId = missionId
            self.totalBlockCount = totalBlockCount
            self.infos = infos
        }
    }
    
    @Reducer
    public enum Destination {
        case missionDelete(MissionDeleteFeature)
    }
    
    
    public enum Action {
        case didTapCloseButton
        case didTapDeleteButton
        case error(Error)
        case destination(PresentationAction<Destination.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapCloseButton:
                return .run { _ in
                    await self.dismiss()
                }
            case .didTapDeleteButton:
                state.destination = .missionDelete(MissionDeleteFeature.State(missionId: state.missionId))
                return .none
            case let .error(error):
                return .none
            case let .destination(action):
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
    
    public init() {}
    
    public struct Info: Identifiable {
        public let id: String
        public let title: String
        public let description: String
        public init(id: String, title: String, description: String) {
            self.id = id
            self.title = title
            self.description = description
        }
    }
}
