//
//  ImageUploadFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/10/24.
//

import Foundation
import UIKit
import DomainPlayerInterface
import ComposableArchitecture

@Reducer
public struct ImageUploadFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        public let player: Player
        public let updatedDate: Date
        public let selectedImage: UIImage
        
        public var formatedDate: String {
            dateFormatter.string(from: updatedDate)
        }
        
        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter
        }()
        
        public init(player: Player, updatedDate: Date = Date.now, selectedImage: UIImage) {
            self.player = player
            self.updatedDate = updatedDate
            self.selectedImage = selectedImage
        }
    }
    
    public enum Action {
        case didTapUploadButton
        case didTapCloseButton
        case didFinishImageUpload
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapUploadButton:
                return .run { send in
                    await send(.didFinishImageUpload)
                }
            case .didTapCloseButton:
                return .run { _ in
                    await self.dismiss()
                }
            case .didFinishImageUpload:
                return .none
            }
        }
    }
    
    public init() {}
}
