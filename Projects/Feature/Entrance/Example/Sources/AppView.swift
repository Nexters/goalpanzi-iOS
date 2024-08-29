import SwiftUI

import FeatureEntranceInterface
import DomainUserInterface
import SharedDesignSystem

import ComposableArchitecture

@main
struct AppView: App {

    init() {
        SharedDesignSystemFontFamily.registerAllCustomFonts()
    }
    var body: some Scene {
        WindowGroup {
            EntranceView(store: .init(initialState: .init(isFirstEntrance: true), reducer: {
                EntranceFeature()
            }
                                     )
            )
        }
    }
}

