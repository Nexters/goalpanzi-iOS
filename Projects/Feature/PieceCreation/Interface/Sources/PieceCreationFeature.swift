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
        var selectedPiece: Piece = .rabbit
        public init() {}
    }
    
    public enum Action {
        case pieceImageTapped(Piece)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
                
            case .pieceImageTapped(let piece):
                state.selectedPiece = piece
                return .none
            }
        }
    }
    
}
