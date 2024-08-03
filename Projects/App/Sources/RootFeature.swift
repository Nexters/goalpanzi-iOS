//
//  RootFeature.swift
//  Feature
//
//  Created by Haeseok Lee on 7/28/24.
//

import ComposableArchitecture
import FeatureLoginInterface

@Reducer
struct RootFeature {
    
    @ObservableState
    struct State {
        @Presents var destination: RootDestination.State?
        var path: StackState<RootPath.State>
        
        init(destination: RootDestination.State? = nil, path: StackState<RootPath.State> = .init()) {
            self.destination = destination
            self.path = path
        }
    }
    
    enum Action {
        case destination(PresentationAction<RootDestination.Action>)
        case path(StackActionOf<RootPath>)
        case didLoad
        case setRootToLogin
        case pushLogin
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didLoad:
                return .run { send in
                    do {
                        try await Task.sleep(2_000_000_000)
                        print("task sleep end")
                        await send(.setRootToLogin)
                    } catch {
                        print("!!!")
                    }
                }
            case .destination:
                return .none
                
            case .path:
                return .none
                
            case .setRootToLogin:
                state.destination = .login(LoginFeature.State())
                return .run { send in
                    do {
                        try await Task.sleep(2_000_000_000)
                        print("task sleep end")
                        await send(.pushLogin)
                    } catch {
                        print("!!!")
                    }
                }
                
            case .pushLogin:
                state.path.append(.login(LoginFeature.State()))
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
        .forEach(\.path, action: \.path)
    }
}
