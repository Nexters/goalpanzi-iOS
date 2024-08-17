//
//  RootPath.swift
//  Feature
//
//  Created by Haeseok Lee on 7/28/24.
//

import Foundation
import ComposableArchitecture
import FeatureLoginInterface
import FeaturePieceCreationInterface
import FeatureHomeInterface
import FeatureEntranceInterface


@Reducer
enum RootDestination {
    case login(LoginFeature)
    case profileCreation(PieceCreationFeature)
    case entrance(EntranceFeature)
    case home(HomeFeature)
}
