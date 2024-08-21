//
//  HomePreview.swift
//  MissionMate
//
//  Created by Haeseok Lee on 8/1/24.
//

import SwiftUI
import DomainPlayerInterface
import FeatureHomeInterface

//struct HomeContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(store: .init(initialState: HomeFeature.State(), reducer: {
//            HomeFeature()
//        }))
//    }
//}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(store: .init(initialState: ImageDetailFeature.State(player: .init(id: "", pieceID: "", name: "하이", character: .rabbit), verifiedAt: Date.now, imageURL: "https://dummyimage.com/900x700/663399/fff"), reducer: {
            ImageDetailFeature()
        }))
    }
}
