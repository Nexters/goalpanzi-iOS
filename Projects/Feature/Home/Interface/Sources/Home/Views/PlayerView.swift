//
//  PlayerView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/15/24.
//

import SwiftUI
import SharedUtil
import SharedDesignSystem
import DomainCompetitionInterface
import DomainPlayerInterface
import ComposableArchitecture

struct PlayerView: View {
    
    let player: Player
    
    let verification: Vertification?
    
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            ZStack(alignment: .top) {
                let shouldDisabled = !player.isMe 
                    && (store.competition?.state == .notStarted(hasOtherPlayer: true) || verification?.isVerified == false)
                Button(action: {
                    store.send(.didTapPlayer(player: player))
                }) {
                    if verification?.isVerified == true {
                        player.character.roundHighlightedImage.swiftUIImage
                            .resizable()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    } else {
                        player.character.roundBorderImage.swiftUIImage
                            .resizable()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                            .opacity(shouldDisabled ? 0.5 : 1.0)
                    }
                }
                .disabled(shouldDisabled)
                if player.isMe {
                    Text("나")
                        .font(.pretendard(kind: .body_md, type: .bold))
                        .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                        .frame(width: 40, height: 18)
                        .background(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                        .clipShape(Capsule())
                        .offset(y: -10)
                }
            }
            
            Text("\(player.name)")
                .font(.pretendard(kind: .body_sm, type: .medium))
                .lineLimit(1)
                .foregroundColor(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
                .frame(width: 70, height: 20)
                .background(SharedDesignSystemAsset.Colors.gray5.swiftUIColor.opacity(0.5))
                .clipShape(Capsule())
                .overlay(Capsule().stroke(SharedDesignSystemAsset.Colors.white.swiftUIColor.opacity(0.5), lineWidth: 1))
                
        }
    }
}
