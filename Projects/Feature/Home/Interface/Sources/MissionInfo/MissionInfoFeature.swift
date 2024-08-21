//
//  MissionInfoFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/8/24.
//

import Foundation
import OrderedCollections
import ComposableArchitecture

@Reducer
public struct MissionInfoFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        
        public let missionId: Int
        
        public let isMeHost: Bool
        
        public let totalBlockCount: Int
        
        public var infos: OrderedDictionary<String, String>
        
        @Presents var destination: Destination.State?
        
        public init(missionId: Int, isMeHost: Bool, totalBlockCount: Int, infos: OrderedDictionary<String, String>) {
            self.missionId = missionId
            self.isMeHost = isMeHost
            self.totalBlockCount = totalBlockCount
            self.infos = infos
        }
    }
    
    @Reducer
    public enum Destination {
        case missionDelete(MissionDeleteFeature)
    }
    
    public enum Action {
        case didTapBackButton
        case didTapBackButtonDelayed
        case didTapDeleteButton
        case destination(PresentationAction<Destination.Action>)
        case delegate(Delegate)
    }
    
    public enum Delegate {
        case didDeleteMission
    }
    
    public enum CancelID {
        case didTapBackButton
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .send(.didTapBackButtonDelayed)
                    .debounce(id: CancelID.didTapBackButton, for: 0.2, scheduler: DispatchQueue.main.eraseToAnyScheduler())
                
            case .didTapBackButtonDelayed:
                return .run { _ in
                    await self.dismiss()
                }
            case .didTapDeleteButton:
                state.destination = .missionDelete(MissionDeleteFeature.State(missionId: state.missionId))
                return .none
                
            case .destination(.presented(.missionDelete(.delegate(.didDeleteMission)))):
                return .send(.delegate(.didDeleteMission))
                
            case .destination:
                return .none
                
            case .delegate:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
    
    public init() {}
}
