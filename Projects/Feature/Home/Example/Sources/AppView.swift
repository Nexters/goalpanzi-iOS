import SwiftUI
import ComposableArchitecture
import FeatureHomeInterface

@main
struct AppView: App {
    var body: some Scene {
        WindowGroup {
            HomeView(store: Store(initialState: HomeFeature.State(), reducer: {
                HomeFeature()
            }))
        }
    }
}

