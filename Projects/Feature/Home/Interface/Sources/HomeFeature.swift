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
        
        public var numberOfColumns: Int
        
        public var numberOfRows: Int
        
        public init() {
            let theme: JejuIslandBoardTheme = JejuIslandBoardTheme(backgroundImageName: "jejuisland")
            let mission: Mission = .init(
                description: "매일 유산소 1시간",
                competition: .init(
                    players: [
                        .init(id: "1", pieceID: "1", name: "이해석", characterImageName: "rabbit"),
                        .init(id: "2", pieceID: "2", name: "김용재", characterImageName: "dog")
                    ],
                    board: .init(
                        theme: theme,
                        blocks: Dictionary(uniqueKeysWithValues: (0..<25).map {
                            let position = Position(index: $0)
                            return (
                                position,
                                Block(
                                    position: position,
                                    theme: theme,
                                    event: ($0 % 3 == .zero && $0 != .zero) ? [.item(.init(image: "", description: "한라봉 먹기"))] : []
                                )
                            )
                        }),
                        pieces: [
                            Piece(id: "1", position: .init(index: .zero)),
                            Piece(id: "2", position: .init(index: .zero))
                        ]
                    )
                )
            )
            self.mission = mission
            self.numberOfColumns = mission.board.numberOfColumns
            self.numberOfRows = Int(ceil((Double(mission.board.totalBlockCount) / Double(mission.board.numberOfColumns))))
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
