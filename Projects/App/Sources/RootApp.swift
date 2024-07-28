import SwiftUI
import CoreNetwork
import CoreNetworkInterface
import ComposableArchitecture
import Alamofire
import Feature

@main
struct MissionMateApp: App {
  var body: some Scene {
    WindowGroup {
        RootView(store: .init(initialState: RootFeature.State()) {
            RootFeature()._printChanges()
        })
    }
  }
}
