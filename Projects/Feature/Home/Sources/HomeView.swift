//
//  HomeView.swift
//  FeatureHome
//
//  Created by Haeseok Lee on 7/24/24.
//

import SwiftUI
import Foundation
import ComposableArchitecture
import SharedThirdPartyLib

@Reducer
struct HomeFeature {
    
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            EmptyReducer()
        }
    }
}
