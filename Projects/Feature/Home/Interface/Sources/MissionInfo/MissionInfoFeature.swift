//
//  MissionInfoFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/4/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MissionInfoFeature {
    
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
