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

    public init() {}

    public var body: some View {
        VStack(spacing: 0) {

            Text("목표가 완성되었어요!")
                .font(.pretendard(kind: .heading_sm, type: .bold))
                .foregroundStyle(Color.mmGray1)
                .padding(.top, 30)

            Spacer()

            Image(uiImage: SharedDesignSystemAsset.Images.jejuIslandFullBackground.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .infinity)

            Spacer()

            VStack(alignment: .center, spacing: 5) {
                Text("이제 시작해볼까요?")
                    .font(.pretendard(kind: .title_xl, type: .bold))
                Text("꾸준히 미션을 완수해")
                    .font(.pretendard(kind: .title_xl, type: .light))
                Text("세꼐 곳곳을 경험해봐요!")
                    .font(.pretendard(kind: .title_xl, type: .light))
            }
            .foregroundStyle(Color.mmGray1)

            Spacer()

            MMRoundedButton(isEnabled: .constant(true), title: "시작하기") {
                // navigation 진행
            }
            .frame(height: 60)
            .padding(.bottom, 36)
            .padding(.horizontal, 24)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
