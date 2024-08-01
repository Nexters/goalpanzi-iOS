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
        var isAllCompleted: Bool = false
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
                state.isValidNickName = self.validate(state.nickName)
                return .none
            default:
                return .none
            }
        }
    }
}

extension PieceCreationFeature {

    private func validate(_ nickName: String) -> Bool {
        guard nickName.count >= 0, nickName.count <= 6 else { return false }
        let pattern = "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]+$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let range = NSRange(location: 0, length: nickName.utf16.count)
        return regex.firstMatch(in: nickName, options: [], range: range) != nil
    }
}
