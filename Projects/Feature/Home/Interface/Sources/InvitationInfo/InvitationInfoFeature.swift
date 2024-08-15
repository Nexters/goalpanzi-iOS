//
//  InvitationInfoFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/5/24.
//

import Foundation
import ComposableArchitecture
import UIKit

@Reducer
public struct InvitationInfoFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        
        public let invitationCode: String
        
        public var codes: [String] {
            invitationCode.map { String($0) }
        }
        
        public init(invitationCode: String) {
            self.invitationCode = invitationCode
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
