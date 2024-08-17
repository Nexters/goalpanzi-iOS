//
//  PieceCreationFeature.swift
//  FeaturePieceCreationInterface
//
//  Created by 김용재 on 7/30/24.
//

import Foundation

import DomainAuthInterface
import DomainUser
import DomainUserInterface
import DataRemote
import DataRemoteInterface

import ComposableArchitecture

@Reducer
public struct PieceCreationFeature: Reducer {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var selectedPiece: Character = .rabbit
        var nickName: String = ""
        var noticeMessage: String? = "1~6자, 한글, 영문 또는 숫자를 입력하세요."
        
        var isValidNickName: Bool = true
        var isAllCompleted: Bool = false
        
        public init() {}
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case pieceImageTapped(Character)
        case saveButtonTapped
        
        case createProfileResponse(Result<Void, Error>)
        case delegate(Delegate)
    }
    
    public enum Delegate {
        case didCreateProfile
    }
    
    @Dependency(UserClient.self) var userClient
    @Dependency(UserService.self) var userService
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce<State, Action> { state, action in
            switch action {
                
            case .binding(\.nickName):
                state.noticeMessage = "1~6자, 한글, 영문 또는 숫자를 입력하세요."
                state.isValidNickName = self.validate(state.nickName)
                state.isAllCompleted = state.isValidNickName && !state.nickName.isEmpty
                return .none
            case .pieceImageTapped(let piece):
                state.selectedPiece = piece
                return .none
            case .saveButtonTapped:
                let nickName = state.nickName
                let piece = state.selectedPiece
                return .run { send in
                    await send(.createProfileResponse(
                        Result { try await self.userClient.createProfile(userService, nickName, piece) }
                    ))
                }
            case .createProfileResponse(.success(_)):
                return .send(.delegate(.didCreateProfile))
            case .createProfileResponse(.failure(let error)):
                guard let error = error as? UserClientError else { return .none }
                switch error {
                case .duplicateNickName:
                    state.noticeMessage = "이미 존재하는 회원 닉네임입니다."
                    state.isValidNickName = false
                case .networkDisabled:
                    print("Network 에러")
                default:
                    print("에러 발생")
                }
                return .none
                
            default:
                return .none
            }
        }
    }
}

extension PieceCreationFeature {
    
    private func validate(_ nickName: String) -> Bool {
        if nickName.isEmpty {
            return true
        }
        guard nickName.count <= 6 else { return false }
        
        let pattern = "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]+$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let range = NSRange(location: 0, length: nickName.utf16.count)
        return regex.firstMatch(in: nickName, options: [], range: range) != nil
    }
}
