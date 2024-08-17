import SwiftUI

import SharedDesignSystem
import FeatureSettingInterface

@main
struct AppView: App {
    
    init() {
        SharedDesignSystemFontFamily.registerAllCustomFonts()
    }
    var body: some Scene {
        WindowGroup {
            SettingView(store: .init(initialState: .init(), reducer: {
                SettingFeature()
            }))
        }
    }
}

