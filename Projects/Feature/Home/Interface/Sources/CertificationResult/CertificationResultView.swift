//
//  CertificationResultView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/8/24.
//

import SwiftUI
import SharedUtil
import SharedDesignSystem
import ComposableArchitecture

public struct CertificationResultView: View {
    
    @Bindable private var store: StoreOf<CertificationResultFeature>
    @State private var scale = 0.5
    
    public init(store: StoreOf<CertificationResultFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            SharedDesignSystemAsset.Colors.black.swiftUIColor.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                VStack(spacing: 32) {
                    VStack(spacing: 12) {
                        Text(store.title)
                            .multilineTextAlignment(.center)
                            .font(.pretendard(kind: .title_xl, type: .bold))
                            .foregroundColor(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
                        
                        Text(store.subtitle)
                            .multilineTextAlignment(.center)
                            .font(.pretendard(kind: .body_lg, type: .regular))
                            .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                    }
                    .padding(.horizontal, 24)
                    
                    if let event = store.event, case let .reward(info) = event {
                        info?.resultImageAsset.swiftUIImage
                            .resizable()
                            .frame(width: 180, height: 180)
                    } else {
                        SharedDesignSystemAsset.Images.move1.swiftUIImage
                            .resizable()
                            .frame(width: 180, height: 180)
                    }
                    
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
