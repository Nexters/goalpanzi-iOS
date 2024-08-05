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
    
    @Bindable private var store: StoreOf<MissionInfoFeature>
    @State private var scale = 0.5
    
    public init(store: StoreOf<MissionInfoFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            SharedDesignSystemAsset.Colors.black.swiftUIColor.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
                .transition(.opacity)
            VStack(spacing: 0) {
                VStack(spacing: 32) {
                    VStack(spacing: 12) {
                        Group {
                            Text("시작일까지 초대된 인원과\n")
                                .font(.pretendard(kind: .title_xl, type: .bold))
                                .foregroundColor(SharedDesignSystemAsset.Colors.black.swiftUIColor)
                            +
                            Text("경쟁이 자동으로")
                                .font(.pretendard(kind: .title_xl, type: .bold))
                                .foregroundColor(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                            +
                            Text(" 시작돼요!")
                                .font(.pretendard(kind: .title_xl, type: .bold))
                                .foregroundColor(SharedDesignSystemAsset.Colors.black.swiftUIColor)
                        }
                        
                        Text("경쟁인원은 최소 2명부터 최대 10명 입니다!")
                            .font(.pretendard(kind: .body_lg, type: .regular))
                            .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                        
                    }
                    .padding(.horizontal, 24)
                    
                    HStack(spacing: 6) {
                        ForEach(Array(["A", "Z", "1", "1"].enumerated()), id: \.offset) { index, letter in
                            Text(letter)
                                .font(.pretendard(kind: .heading_md, type: .bold))
                                .foregroundStyle(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                                .frame(width: 72, height: 72)
                                .background(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(SharedDesignSystemAsset.Colors.gray4.swiftUIColor, lineWidth: 1)
                                )
                        }
                    }
                    
                    VStack(spacing: 8) {
                        Button(action: {
                            // 친구 초대 코드 복사 액션
                        }) {
                            Text("친구 초대 코드 복사")
                                .font(.pretendard(kind: .body_lg, type: .bold))
                                .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .background(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                                .cornerRadius(30)
                        }
                        Button(action: {
                            store.send(.didTapCloseButton)
                        }) {
                            Text("닫기")
                                .font(.pretendard(kind: .body_lg, type: .bold))
                                .foregroundColor(SharedDesignSystemAsset.Colors.gray3.swiftUIColor)
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.top, 40)
                .padding(.bottom, 22)
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
