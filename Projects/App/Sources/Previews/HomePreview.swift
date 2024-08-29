//
//  HomePreview.swift
//  MissionMate
//
//  Created by Haeseok Lee on 8/1/24.
//

import SwiftUI
import DomainPlayerInterface
import FeatureHomeInterface
import SharedDesignSystem

//struct HomeContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(store: .init(initialState: HomeFeature.State(), reducer: {
//            HomeFeature()
//        }))
//    }
//}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploadView(store: .init(initialState: ImageUploadFeature.State(missionId: 0, player: .init(id: "", pieceID: "", name: "하이", character: .rabbit), selectedImage: SharedDesignSystemAsset.Images.basicCat.image), reducer: {
            ImageUploadFeature()
        }))
    }
}
