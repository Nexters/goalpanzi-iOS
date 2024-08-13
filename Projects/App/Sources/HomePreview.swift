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

//struct MissionInfoContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionInfoView(store: .init(
//            initialState: MissionInfoFeature.State(missionId: 0, totalBlockCount: 30, infos: [
//                .init(id: "1", title: "미션", description: "매일 유산소 1시간"),
//                .init(id: "2", title: "미션 기간", description: "2024.05.16~2024.06.17"),
//                .init(id: "3", title: "인증 요일", description: "월/화/목"),
//                .init(id: "4", title: "인증 시간", description: "오전 00~12시")
//            ]),
//            reducer: {
//                MissionInfoFeature()
//            }
//        ))
//    }
//}

struct FinishContentView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(store: .init(
            initialState: FinishFeature.State(missionId: 0, player: Player(id: "", pieceID: "", name: "name", character: .rabbit), rank: 10),
            reducer: {
                FinishFeature()
            }
        ))
    }
}
