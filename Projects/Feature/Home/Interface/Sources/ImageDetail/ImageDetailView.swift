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
    
    public var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                KFImage(URL(string: store.imageURL ?? ""))
                    .placeholder({ Color.black })
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
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
                .padding(.top, 14)
                .padding(.horizontal, 24)
            }
        }
    }
}
