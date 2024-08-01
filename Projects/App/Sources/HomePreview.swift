//
//  HomePreview.swift
//  MissionMate
//
//  Created by Haeseok Lee on 8/1/24.
//

import SwiftUI
import FeatureHomeInterface

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: .init(initialState: HomeFeature.State(), reducer: {
            HomeFeature()
        }))
    }
}
