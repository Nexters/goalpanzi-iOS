//
//  HomeBottomView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/15/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

struct HomeBottomView: View {
    
    @Bindable var store: StoreOf<HomeFeature>
    
    var body: some View {
        VStack {
            HStack(spacing: 8){
                SharedDesignSystemAsset.Images.timeFill.swiftUIImage
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
                Text(store.ctaButtonState.info)
                    .font(.pretendard(kind: .body_lg, type: .bold))
                    .foregroundColor(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
            }
            .padding(.top, 16)
            .padding(.bottom, 6)
            
            PhotoPickerView(selectedImages: $store.selectedImages.sending(\.didSelectImages), maxSelectedCount: 1) {
                Text(store.ctaButtonState.title)
                    .font(.pretendard(kind: .body_lg, type: .bold))
                    .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(
                        store.ctaButtonState.isEnabled
                        ? SharedDesignSystemAsset.Colors.orange.swiftUIColor
                        : SharedDesignSystemAsset.Colors.disabled.swiftUIColor
                    )
                    .cornerRadius(30)
            }
            .padding(.horizontal, HomeView.Constant.horizontalPadding)
            .padding(.bottom, 36)
            .disabled(!store.ctaButtonState.isEnabled)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .frame(height: 60)
    }
}
