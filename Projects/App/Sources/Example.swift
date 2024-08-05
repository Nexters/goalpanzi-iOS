//
//  Example.swift
//  MissionMate
//
//  Created by Miro on 8/3/24.
//

import SwiftUI
import FeaturePieceCreationInterface

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PieceCreationView(
            store: .init(
                initialState: .init(),
                reducer: {
                    PieceCreationFeature()._printChanges()
                }
            )
        )
    }
}
