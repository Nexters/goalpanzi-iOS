//
//  MissionInvitationInfoFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/5/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MissionInvitationInfoFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        
        public init() {
            
        }
    }
    
    
    public enum Action {
        case didTapCloseButton
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapCloseButton:
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
    
    public init() {}
}