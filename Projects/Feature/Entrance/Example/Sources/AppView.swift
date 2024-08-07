import SwiftUI
import FeatureEntranceInterface
import SharedDesignSystem

@main
struct AppView: App {

    init() {
        SharedDesignSystemFontFamily.registerAllCustomFonts()
    }
    var body: some Scene {
        WindowGroup {
            MissionDurationSettingView(store: .init(initialState: .init(), reducer: {
                MissionDurationSettingFeature()._printChanges()
            }))
        }
    }
}

