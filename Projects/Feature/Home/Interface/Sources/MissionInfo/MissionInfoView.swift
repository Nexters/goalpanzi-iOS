//
//  MissionInfoView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/4/24.
//

import SwiftUI
import SharedUtil
import SharedDesignSystem
import ComposableArchitecture

public struct MissionInfoView: View {
    
    private let store: StoreOf<MissionInfoFeature>
    @State private var scale = 0.5
    
    public init(store: StoreOf<MissionInfoFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            SharedDesignSystemAsset.Colors.black.swiftUIColor.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                VStack(spacing: 29) {
                    VStack(spacing: 12) {
                        Text("경쟁 내용")
                            .font(.pretendard(kind: .title_xl, type: .bold))
                            .foregroundColor(SharedDesignSystemAsset.Colors.black.swiftUIColor)
                        Group {
                            Text("*기간 대비 인증요일을 계산해\n")
                                .font(.pretendard(kind: .body_xl, type: .regular))
                                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                            +
                            Text("인증횟수(보드판 수)는 총 12개 ")
                                .font(.pretendard(kind: .body_xl, type: .regular))
                                .foregroundColor(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                            +
                            Text("가 \n생성되었어요")
                                .font(.pretendard(kind: .body_xl, type: .regular))
                                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                        }
                        .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 24)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(Array(store.infos.enumerated()), id: \.offset) { index, info in
                            VStack(alignment: .leading, spacing: 0) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(info.title)
                                        .font(.pretendard(kind: .body_md, type: .regular))
                                        .foregroundStyle(SharedDesignSystemAsset.Colors.gray3.swiftUIColor)
                                    Text(info.description)
                                        .font(.pretendard(kind: .body_lg, type: .bold))
                                        .foregroundStyle(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                                }
                                VStack(spacing: 0) {
                                    Spacer()
                                    Divider()
                                        .frame(height: 1)
                                        .background(SharedDesignSystemAsset.Colors.gray4.swiftUIColor)
                                    Spacer()
                                }
                                .frame(height: 32)
                                .isHidden(store.infos.count - 1 == index, remove: true)
                            }
                            
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Button(action: {
                        store.send(.didTapCloseButton)
                    }) {
                        Text("확인")
                            .font(.pretendard(kind: .body_lg, type: .bold))
                            .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                            .cornerRadius(30)
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.top, 40)
                .padding(.bottom, 34)
            }
            .frame(maxWidth: .infinity)
            .background(SharedDesignSystemAsset.Colors.white.swiftUIColor)
            .cornerRadius(20)
            .padding(.horizontal, 24)
            .scaleEffect(scale)
            .animate(using: .spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)) {
                scale = 1.0
            }
        }
    }
}
