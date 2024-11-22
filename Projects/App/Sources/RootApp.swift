import SwiftUI
import SharedDesignSystem
import CoreNetwork
import CoreNetworkInterface
import ComposableArchitecture
import Alamofire
import Feature

@main
struct MissionMateApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        SharedDesignSystemFontFamily.registerAllCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(store: .init(initialState: RootFeature.State()) {
                RootFeature()._printChanges()
            })
        }
    }
}
