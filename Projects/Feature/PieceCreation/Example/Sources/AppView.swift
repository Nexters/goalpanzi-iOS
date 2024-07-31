import SwiftUI

import FeaturePieceCreationInterface

@main
struct AppView: App {
    var body: some Scene {
        WindowGroup {
            PieceCreationView(
                store: .init(
                    initialState: .init(), reducer: {PieceCreationFeature()._printChanges()}
                )
            )
        }
    }
}

