//
//  ImageDetailView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/10/24.
//

import Foundation
import Kingfisher
import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

public struct ImageDetailView: View {
    
    let store: StoreOf<ImageDetailFeature>
    
    public init(store: StoreOf<ImageDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            SharedDesignSystemAsset.Colors.white.swiftUIColor
                .edgesIgnoringSafeArea(.all)
                .overlay {
                    KFImage(URL(string: store.imageURL ?? ""))
                        .placeholder({ Color.black })
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea([.horizontal, .bottom])
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
    }
}
