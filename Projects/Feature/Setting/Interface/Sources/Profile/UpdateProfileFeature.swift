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
        var selectedCharacter: Character = .rabbit
        var nickName: String = ""
        var initialNickName: String = ""
        var initialCharacter: Character = .rabbit

        var noticeMessage: String? = "1~6자, 한글, 영문 또는 숫자를 입력하세요."
        var isValidNickName: Bool = true
        var isAllCompleted: Bool = false // 모든 Input이 알맞게 들어갔는 지 확인
        var isCheckingProfile: Bool = true // 앱 초기 진입 시 API 호출

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)

        case pieceImageTapped(Character)
        case saveButtonTapped
        case backButtonTapped

        case onAppear

        case checkProfileResponse(Result<UserProfile, Error>)
        case updateProfileResponse(Result<Void, Error>)

        public enum Delegate {
            case didUpdateProfileSucceed
        }

        case delegate(Delegate)
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(UserClient.self) var userClient
    @Dependency(UserService.self) var userService

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce<State, Action> { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.checkProfileResponse(
                        Result { try await self.userClient.checkProfile(userService) }
                    ))
                }
            case .binding(\.nickName):
                state.noticeMessage = "1~6자, 한글, 영문 또는 숫자를 입력하세요."
                state.isValidNickName = self.validate(state.nickName)
                state.isAllCompleted = self.isAvailableToSave(with: &state)
                return .none

            case .pieceImageTapped(let character):
                state.selectedCharacter = character
                state.isAllCompleted = self.isAvailableToSave(with: &state)

                return .none
            case .backButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }

                // MARK: 기존 프로필 체크
            case .checkProfileResponse(.success(let userProfile)):
                state.nickName = userProfile.nickname
                state.selectedCharacter = userProfile.character
                state.initialCharacter = userProfile.character
                state.initialNickName = userProfile.nickname
                state.isCheckingProfile = false
                return .none
            case .checkProfileResponse(.failure(let error)):
                print("🚨 에러 발생!! \(error)")
                return .none
                // MARK: 프로필 업데이트
            case .saveButtonTapped:
                let nickName = state.nickName
                let piece = state.selectedCharacter
                return .run { send in
                    await send(.updateProfileResponse(
                        Result { try await self.userClient.createProfile(userService, nickName, piece) }
                    ))
                }
            case .updateProfileResponse(.success(_)):
                return .run { send in
                    await send(.delegate(.didUpdateProfileSucceed))
                    await self.dismiss()
                }
            case .updateProfileResponse(.failure(let error)):
                guard let error = error as? UserClientError else { return .none }
                switch error {
                case .duplicateNickName:
                    state.noticeMessage = "이미 존재하는 회원 닉네임입니다."
                    state.isValidNickName = false
                    state.isAllCompleted = false
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

    private func isAvailableToSave(with state: inout State) -> Bool {
        let isCharacterEquals = state.initialCharacter == state.selectedCharacter
        let isNicknameEquals = state.initialNickName == state.nickName
        let isAllEqual = isCharacterEquals && isNicknameEquals
        return state.isValidNickName && !state.nickName.isEmpty && !isAllEqual
    }
}
