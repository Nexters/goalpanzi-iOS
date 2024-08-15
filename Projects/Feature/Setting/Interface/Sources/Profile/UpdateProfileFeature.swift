//
//  UpdateProfileFeature.swift
//  FeatureSetting
//
//  Created by 김용재 on 8/15/24.
//

import Foundation

import DomainAuthInterface
import DomainUser
import DomainUserInterface
import DataRemote
import DataRemoteInterface

import ComposableArchitecture

@Reducer
public struct UpdateProfileFeature: Reducer {
    
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

        case _setDuplicatedNicknameError
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
                    do {
                        try await userClient.createProfile(userService, nickName, piece)
                    } catch let error as UserClientError { // 닉네임
                        switch error {
                        case .duplicateNickName:
                            await send(._setDuplicatedNicknameError)
                        case .networkDisabled:
                            print("Network 에러")
                        default:
                            print("에러 발생")
                        }
                    }
                }
            case ._setDuplicatedNicknameError:
                state.noticeMessage = "이미 존재하는 회원 닉네임입니다."
                state.isValidNickName = false
                return .none
            default:
                return .none
            }
        }
    }
}

extension UpdateProfileFeature {

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
