//
//  LoginView.swift
//  FeatureLoginInterface
//
//  Created by Haeseok Lee on 7/28/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

public struct LoginView: View {
    
    public let store: StoreOf<LoginFeature>
    
    public init(store: StoreOf<LoginFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(content: {
            Text("Login View")
        })
    }
}
