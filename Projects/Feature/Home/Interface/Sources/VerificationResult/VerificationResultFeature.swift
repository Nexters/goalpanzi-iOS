//
//  VerificationResultFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/8/24.
//

import Foundation
import DomainBoardInterface
import ComposableArchitecture

@Reducer
public struct VerificationResultFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        
        public let event: DomainBoardInterface.Event?
        public var title: String
        public var subtitle: String
        
        public init(event: DomainBoardInterface.Event? = nil) {
            self.event = event
            if let event, case let .reward(info) = event, let info {
                title = "인증완료!!\n'\(info.description)'를 획득했어요!"
                subtitle = "꾸준히 하면 재밌는 이벤트가 또 나타날걸요?"
            } else {
                title = "인증완료!!\n한 칸 이동했어요."
                subtitle = "대단해요 오늘도 해냈어요."
            }
        }
    }
    
    
    public enum Action {
        case didTapCloseButton
        case delegate(Delegate)
    }
    
    public enum Delegate {
        case didTapCloseButton
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapCloseButton:
                return .concatenate(
                    .run { _ in
                        await self.dismiss()
                    },
                    .send(.delegate(.didTapCloseButton))
                )
            case .delegate:
                return .none
            }
        }
    }
    
    public init() {}
}
