//
//  RootPath.swift
//  Feature
//
//  Created by Haeseok Lee on 7/28/24.
//

import Foundation
import ComposableArchitecture
import FeatureLoginInterface


@Reducer
enum RootDestination {
    case login(LoginFeature)
}
