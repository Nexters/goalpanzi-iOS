//
//  EnvironmentValues+.swift
//  SharedUtil
//
//  Created by Haeseok Lee on 11/7/24.
//

import SwiftUI

extension EnvironmentValues {
    @Entry public var safeAreaInsets: UIEdgeInsets = {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .safeAreaInsets ?? .zero
    }()
}
