import SwiftUI
import Foundation
import ComposableArchitecture
import DomainMissionInterface
import DomainBoardInterface
import DomainPlayerInterface
import DomainCompetitionInterface
import SharedThirdPartyLib

@Reducer
public struct HomeFeature {
    
    @ObservableState
    public struct State {
        public var mission: Mission
        public var competition: Competition
        
        public init() {
            let theme: JejuIslandBoardTheme = .init()
            let mission: Mission = .init(description: "매일 유산소 1시간")
            let competition: Competition = .init(
                players: [
                    .init(id: "1", pieceID: "1", name: "이해석", characterImageName: "rabbit", isMe: true),
                    .init(id: "2", pieceID: "2", name: "김용재", characterImageName: "dog")
                ],
                board: .init(
                    theme: theme,
                    events: [.item(.init(image: "", position: Position(index: 2), description: "단감 먹기"))],
                    pieces: [
                        .init(id: "1", position: Position(index: 0)),
                        .init(id: "2", position: Position(index: 1))
                    ],
                    totalBlockCount: 25,
                    conqueredIndex: 11,
                    isDisabled: false
                )
            )
            self.mission = mission
            self.competition = competition
        }
    }
    
    public enum Action {
        case onAppear
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
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
