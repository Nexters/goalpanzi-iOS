//
//  MissionDeleteAlertView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/5/24.
//

import SwiftUI
import SharedUtil
import SharedDesignSystem
import ComposableArchitecture

public struct MissionDeleteAlertView: View {
    
    @Bindable private var store: StoreOf<MissionDeleteAlertFeature>
    @State private var scale = 0.5
    
    public init(store: StoreOf<MissionDeleteAlertFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            SharedDesignSystemAsset.Colors.black.swiftUIColor.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                VStack(spacing: 32) {
                    VStack(spacing: 12) {
                        Text("시작일까지 아무도 오지않아\n미션보드를 삭제할게요.")
                            .multilineTextAlignment(.center)
                            .font(.pretendard(kind: .title_xl, type: .bold))
                            .foregroundColor(SharedDesignSystemAsset.Colors.black.swiftUIColor)
                        
                        Text("미션보드는 삭제되고\n초기화면 화면으로 이동해요.")
                            .multilineTextAlignment(.center)
                            .font(.pretendard(kind: .body_lg, type: .regular))
                            .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                    }
                    .padding(.horizontal, 24)
                    
                    Button(action: {
                        store.send(.didTapConfirmButton)
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
