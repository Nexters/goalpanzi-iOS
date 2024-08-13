//
//  ImageUploadFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/10/24.
//

import Foundation
import UIKit
import DataRemote
import DataRemoteInterface
import DomainPlayerInterface
import ComposableArchitecture

@Reducer
public struct ImageUploadFeature {
    
    @Dependency(MissionVerificationService.self) var verificationService
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        public let missionId: Int
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
        
        public init(missionId: Int, player: Player, updatedDate: Date = Date.now, selectedImage: UIImage) {
            self.missionId = missionId
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
                return .run { [
                    missionId = state.missionId, 
                    selectedImage = state.selectedImage,
                    player = state.player
                ] send in
                    if let data = selectedImage.jpegData(compressionQuality: 0.8) {
                        _ = try await verificationService.postVerificationsMe(missionId, "\(player.name)", data)
                    }
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
