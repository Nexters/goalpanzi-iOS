//
//  ImageDetailFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/10/24.
//

import Foundation
import DomainPlayerInterface
import DomainCompetitionInterface
import ComposableArchitecture

@Reducer
public struct ImageDetailFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        public let player: Player
        public let verifiedAt: Date?
        public let imageURL: String?
        
        public var formatedDate: String {
            dateFormatter.string(from: verifiedAt ?? .now)
        }
        
        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter
        }()
        
        public init(player: Player, verifiedAt: Date?, imageURL: String?) {
            self.player = player
            self.verifiedAt = verifiedAt
            self.imageURL = imageURL
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
}
