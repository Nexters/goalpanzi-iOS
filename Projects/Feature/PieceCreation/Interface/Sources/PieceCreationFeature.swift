//
//  PieceCreationFeature.swift
//  FeaturePieceCreationInterface
//
//  Created by 김용재 on 7/30/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct PieceCreationFeature: Reducer {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
                
            }
        }
    }
    
}
