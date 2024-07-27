import SwiftUI
import Foundation
import ComposableArchitecture
import SharedThirdPartyLib

@Reducer
public struct HomeFeature {
    
    @ObservableState
    public struct State: Equatable {
        
        public var players: [Player]
        public init() {
            self.players = .init()
        }
    }
    
    public enum Action {
        case onAppear
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.players = [
                    Player(name: "이리율"),
                    Player(name: "유지민"),
                    Player(name: "정석준"),
                    Player(name: "이창엽"),
                    Player(name: "김송이"),
                    Player(name: "김유정"),
                    Player(name: "김용재"),
                    Player(name: "이해석"),
                    Player(name: "이해석"),
                    Player(name: "이해석"),
                ]
                return .none

            }
        }
    }
    
    public init() {}
}


public struct Player: Equatable, Identifiable {
    
    public let id: String
    
    public let name: String
    
    public init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
}
