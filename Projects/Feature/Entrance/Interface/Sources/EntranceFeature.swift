//
//  EntranceFeature.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/5/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct EntranceFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {

    }

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {

            }
        }
    }
}
