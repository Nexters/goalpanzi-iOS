//
//  EntranceView.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/5/24.
//

import SwiftUI

import SharedDesignSystem

public struct EntranceView: View {

    public init() {}

    public var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Text("미션 완수를 위해\n경쟁할 준비가 되었나요?")
                .font(.pretendard(kind: .heading_sm, type: .bold))
                .multilineTextAlignment(.center)

            Spacer(minLength: 52)

            MMRoundedCapsuleView(text: "LV1. 제주도")

            Spacer()

            ZStack {
                Image(uiImage: SharedDesignSystemAsset.Images.jejuIslandBackground.image)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 228)

                Image(uiImage: SharedDesignSystemAsset.Images.appleIcon.image)
                    .frame(width: 212, height: 212)
            }

            Spacer()

            HStack(spacing: 23) {
                missionBoardButton(
                    title: "미션보드\n생성하기",
                    description: "내 목표는 내가~",
                    iconImage: SharedDesignSystemAsset.Images.coloredPencil.image
                ) {
                    print("미션보드 생성")
                }

                missionBoardButton(
                    title: "초대코드\n입력하기",
                    description: "초대받고 왔지~",
                    iconImage: SharedDesignSystemAsset.Images.coloredAddPerson.image
                ) {
                    print("미션보드 생성")
                }
            }

            Spacer()
        }
    }

    private func missionBoardButton(title: String, description: String, iconImage: UIImage, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 20)
                .stroke(SharedDesignSystemAsset.Colors.black.swiftUIColor.opacity(0.2), lineWidth: 1)
                .frame(width: 162, height: 188)
                .overlay(
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(.pretendard(kind: .title_xl, type: .bold))
                                .foregroundStyle(SharedDesignSystemAsset.Colors.grey1.swiftUIColor)
                                .multilineTextAlignment(.leading)
                            Text(description)
                                .font(.pretendard(kind: .body_lg, type: .medium))
                                .foregroundStyle(SharedDesignSystemAsset.Colors.gray3.swiftUIColor)
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            Image(uiImage: iconImage)
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                        .padding(20)
                )
        }
    }

    struct MMRoundedCapsuleView: View {
        let text: String

        var body: some View {
            Text(text)
                .font(.pretendard(kind: .title_lg, type: .medium))
                .foregroundColor(.orange)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(.clear)
                )
                .overlay(
                    Capsule()
                        .stroke(.orange, lineWidth: 1)
                )
        }
    }
}
