//
//  MyHistoryFeature.swift
//  MissionMate
//
//  Created by Haeseok Lee on 5/11/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MyHistoryFeature {
    
    @ObservableState
    struct State {
        
    }
    
    enum Action {
        case didLoad
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didLoad:
                return .none
            }
        }
    }
}
