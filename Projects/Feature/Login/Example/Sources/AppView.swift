import SwiftUI

import FeatureLoginInterface

@main
struct AppView: App {
    var body: some Scene {
        WindowGroup {
            LoginView(
                store: .init(
                    initialState: .init(),
                    reducer: { LoginFeature()._printChanges()}
                )
            )
        }
    }
}
