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
        var nickName: String = ""
        var isValidNickName: Bool = true
        public init() {}
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)

        case pieceImageTapped(Piece)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce<State, Action> { state, action in
            switch action {

            case .pieceImageTapped(let piece):
                state.selectedPiece = piece
                return .none
            case .binding(\.nickName):
                if state.nickName.count > 7 {
                    state.isValidNickName = false
                } else {
                    state.isValidNickName = true
                }
                return .none
            default:
                return .none
            }
        }
    }

}
