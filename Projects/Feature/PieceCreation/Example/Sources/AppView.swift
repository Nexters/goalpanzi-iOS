import SwiftUI

import FeaturePieceCreationInterface
import SharedDesignSystem
@main
struct AppView: App {
    var body: some Scene {
        WindowGroup {
            PieceCreationView(
                store: .init(
                    initialState: .init(), reducer: {PieceCreationFeature()._printChanges()}
                )
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

