//
//  MissionInfoFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/4/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MissionInfoFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        
        public var infos: [Info]
        
        public init() {
            self.infos = [
                .init(id: "1", title: "미션", description: "매일 유산소 1시간"),
                .init(id: "2", title: "미션 기간", description: "2024.07.24~2024.08.14"),
                .init(id: "3", title: "인증 요일", description: "월/수/목"),
                .init(id: "4", title: "인증 시간", description: "오전 00 ~12시")
            ]
        }
    }
    
    
    public enum Action {
        case didTapCloseButton
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapCloseButton:
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
    
    public init() {}
    
    public struct Info: Identifiable {
        public let id: String
        public let title: String
        public let description: String
        public init(id: String, title: String, description: String) {
            self.id = id
            self.title = title
            self.description = description
        }
    }
}
