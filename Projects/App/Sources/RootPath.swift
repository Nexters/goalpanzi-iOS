//
//  RootPath.swift
//  MissionMate
//
//  Created by Haeseok Lee on 8/3/24.
//

import Foundation
import ComposableArchitecture
import FeatureLoginInterface


@Reducer
enum RootPath {
    case login(LoginFeature)
}
