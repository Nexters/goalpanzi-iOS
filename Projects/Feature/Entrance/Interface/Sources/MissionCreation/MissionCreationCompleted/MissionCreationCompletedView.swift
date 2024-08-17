//
//  MissionCreationCompletedView.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/8/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct MissionCreationCompletedView: View {
    
    public var store: StoreOf<MissionCreationCompletedFeature>

    public init(store: StoreOf<MissionCreationCompletedFeature>) {
        self.store = store
    }
    
    public var body: some View {
        
        ZStack {
            Image(uiImage: SharedDesignSystemAsset.Images.jejuIslandMaskBackground.image)
                .resizable()
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0) {

                Text("미션설정 완료!\n이제 시작해볼까요?")
                    .multilineTextAlignment(.center)
                    .font(.pretendard(kind: .heading_sm, type: .bold))
                    .foregroundStyle(Color.mmGray1)
                    .padding(.top, 48)

                Spacer()
                
                MMCapsuleTagView(
                    text: "LV1. 제주도",
                    font: .pretendard(kind: .title_lg, type: .medium),
                    horizontalPadding: 16,
                    verticalPadding: 4
                )
                .padding(.bottom, 12)

                Image(uiImage: SharedDesignSystemAsset.Images.jejuIslandBackground.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 7)
                    .padding(.bottom, 29)
                
                Text("친구와 함께 꾸준히 미션을 완수해\n 세계 곳곳을 경험해봐요!")
                    .multilineTextAlignment(.center)
                    .font(.pretendard(kind: .body_xl, type: .light))
                    .foregroundStyle(Color.mmGray1)

                Spacer()

                MMRoundedButton(isEnabled: .constant(true), title: "시작하기") {
                    print("잉?.....")
                    store.send(.startButtonTapped)
                }
                .frame(height: 60)
                .padding(.bottom, 36)
                .padding(.horizontal, 24)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
