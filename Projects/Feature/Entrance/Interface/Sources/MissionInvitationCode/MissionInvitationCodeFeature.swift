//
//  MissionInvitationCodeFeature.swift
//  FeatureEntrance
//
//  Created by Miro on 8/8/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct MissionInvitationCodeFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {
        var firstInputCode: String = ""
        var secondInputCode: String = ""
        var thirdInputCode: String = ""
        var fourthInputCode: String = ""

        var isInvalid: Bool = false
        var isAllEmpty: Bool = true
        var isAllTexFieldFilled = false

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case confirmButtonTapped
        case backButtonTapped
    }
    
    @Dependency(\.dismiss) var dismiss

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .binding(\.firstInputCode):
                state.isAllEmpty = (state.firstInputCode == "") ? true : false
                return .none
            case .binding(\.fourthInputCode):
                if state.fourthInputCode != "" {
                    state.isAllTexFieldFilled = true
                    state.isInvalid = false
                } else {
                    state.isAllTexFieldFilled = false
                }
                return .none
            case .confirmButtonTapped:
                // 여기서 비동기 처리
                print("뭐냐!!!!")
                state.isInvalid = true
                return .none
            case .backButtonTapped:
                return .run { _ in
                  await self.dismiss()
                }
            default:
                return .none
            }
        }
    }
}
