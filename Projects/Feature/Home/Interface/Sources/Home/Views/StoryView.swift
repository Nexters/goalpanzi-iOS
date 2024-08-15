//
//  StoryView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/15/24.
//

import SwiftUI
import ComposableArchitecture

struct StoryView: View {
    
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(store.competition?.players ?? []) { player in
                    PlayerView(player: player, store: store)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 14)
            .padding(.horizontal, 23)
        }
        .frame(height: 122)
    }
}

