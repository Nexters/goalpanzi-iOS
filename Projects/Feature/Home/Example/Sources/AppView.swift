import SwiftUI
import SharedDesignSystem
import ComposableArchitecture
import FeatureHomeInterface

@main
struct AppView: App {
    
    init() {
        SharedDesignSystemFontFamily.registerAllCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(store: Store(initialState: HomeFeature.State(), reducer: {
                HomeFeature()
            }))
        }
    }
}

