//
//  RootFeature.swift
//  Feature
//
//  Created by Haeseok Lee on 7/28/24.
//

import ComposableArchitecture
import FeatureLoginInterface

@Reducer
struct RootFeature {
    
    @ObservableState
    struct State {
        @Presents var destination: RootDestination.State?
        
        init(destination: RootDestination.State? = nil) {
            self.destination = .login(LoginFeature.State())
        }
    }
    
    enum Action {
        case destination(PresentationAction<RootDestination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
        .ifLet(\.$destination, action: \.destination)
    }
    
    init() {}
}
