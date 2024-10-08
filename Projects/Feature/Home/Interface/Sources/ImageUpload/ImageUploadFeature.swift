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
        public var isLoading: Bool = false
        
        public var formatedDate: String {
            DateFormatter.yearMonthDayFormatter.string(from: updatedDate)
        }
        
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
        case didFinishImageUpload(Result<Void, Error>)
        case delegate(Delegate)
    }
    
    public enum Delegate {
        case didFinishImageUpload
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapUploadButton:
                state.isLoading = true
                return .run { [
                    missionId = state.missionId, 
                    selectedImage = state.selectedImage
                ] send in
                    await send(.didFinishImageUpload(
                        Result {
                            if let data = selectedImage.jpegData(compressionQuality: 0.5) {
                                return try await verificationService.postVerificationsMe(missionId, data)
                            }
                        }
                    ))
                }
            case .didTapCloseButton:
                return .run { _ in
                    await self.dismiss()
                }
            case .didFinishImageUpload(.success):
                state.isLoading = false
                return .concatenate(
                    .send(.delegate(.didFinishImageUpload)),
                    .run { _ in
                        await self.dismiss()
                    }
                )
            case .didFinishImageUpload(.failure):
                state.isLoading = false
                return .none
            case .delegate:
                return .none
            }
        }
    }
    
    public init() {}
}
