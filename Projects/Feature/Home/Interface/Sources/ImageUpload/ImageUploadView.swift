//
//  ImageUploadView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/10/24.
//
import Foundation
import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

public struct ImageUploadView: View {
    
    let store: StoreOf<ImageUploadFeature>
    
    public init(store: StoreOf<ImageUploadFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                SharedDesignSystemAsset.Colors.white.swiftUIColor
                    .edgesIgnoringSafeArea(.all)
                    .overlay {
                        Image(uiImage: store.selectedImage)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea([.horizontal, .bottom])
                    }
                    .overlay {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .isHidden(!store.isLoading, remove: true)
                    }
                
                LinearGradient(gradient: Gradient(colors: [.black.opacity(0.4), .clear]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 93)
                
                HStack(alignment: .center, spacing: 8) {
                    store.player.character.roundBorderImage.swiftUIImage
                        .resizable()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                    
                    Text(store.player.name)
                        .font(.pretendard(kind: .body_xl, type: .bold))
                        .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                    
                    Text(store.formatedDate)
                        .font(.pretendard(kind: .body_xl, type: .light))
                        .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                    
                    Spacer()
                    
                    Button(action: {
                        store.send(.didTapCloseButton)
                    }) {
                        SharedDesignSystemAsset.Images.closeRound.swiftUIImage
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                            .frame(width: 40, height: 40)
                    }
                }
                .frame(height: 40)
                .padding(.top, 14)
                .padding(.horizontal, 24)
            }
            Button(action: {
                store.send(.didTapUploadButton)
            }) {
                Text("업로드")
                    .font(.pretendard(kind: .body_lg, type: .bold))
                    .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                    .cornerRadius(30)
            }
            .padding(.horizontal, 24)
        }
    }
}
