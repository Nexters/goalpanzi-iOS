//
//  Competition.swift
//  DomainCompetitionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import DomainMissionInterface
import DomainBoardInterface
import DomainPlayerInterface

public struct Competition {
    
    public var players: [Player]
    
    public var verifications: [Vertification]
    
    public var state: State
    
    public var info: [InfoKey: String]
    
    public var board: Board
    
    public init(
        players: [Player],
        verifications: [Vertification],
        board: Board,
        info: [InfoKey: String] = [:],
        state: State
    ) {
        self.players = players
        self.verifications = verifications
        self.board = board
        self.info = info
        self.state = state
        self.board.update(pieces: createPieces(by: players))
    }
    
    public var me: Player? {
        players.first(where: { $0.isMe == true })
    }
    
    public var myPiece: Piece? {
        guard let me else { return nil }
        return board.findPiece(by: me.pieceID)
    }
    
    public func findVerification(by playerID: PlayerID) -> Vertification? {
        return verifications.first(where: { $0.playerID == playerID })
    }
    
    public func representativePiece(by position: Position) -> Piece? {
        let result = board.findPieces(by: position)
        if let myPiece = result.first(where: { $0.id == myPiece?.id }) {
            return myPiece
        }
        return result.first
    }
    
    public mutating func sortPlayersByVerifiedAt() {
        players = players.sorted(by: { lhs, rhs in
            guard let lhsResult = findVerification(by: lhs.id)?.verifiedAt,
                  let rhsResult = findVerification(by: rhs.id)?.verifiedAt else { return false }
            return lhsResult > rhsResult
        })
    }
    
    public mutating func moveMeToFront() {
        guard let meIndex = players.firstIndex(where: { $0.isMe }) else { return }
        let me = players.remove(at: meIndex)
        players.insert(me, at: .zero)
    }
    
    public mutating func createPieces(by players: [Player]) -> [Position: [Piece]] {
        Dictionary(uniqueKeysWithValues: [(
                Position(index: .zero),
                players.map { player in
                    Piece(
                        id: player.pieceID,
                        position: .init(index: .zero),
                        image: player.character.basicImage,
                        name: player.name,
                        isHighlighted: player.isMe
                    )
                }
            )]
        )
    }
}

public extension Competition {
    
    enum State: Equatable {
        case notStarted(hasOtherPlayer: Bool)
        case started
        case disabled
        case finished
    }
    
    enum InfoKey {
        case title
        case subtitle
    }
}

public extension Mission {
    
    func competitionState(hasOtherPlayers: Bool) -> Competition.State {
        if missionEndDate <= Date.now {
            return .finished
        }
        if missionStartDate <= Date.now, hasOtherPlayers == false {
            return .disabled
        }
        if missionStartDate <= Date.now, hasOtherPlayers == true {
            return .started
        }
        if missionStartDate > Date.now, hasOtherPlayers == false {
            return .notStarted(hasOtherPlayer: false)
        }
        if missionStartDate > Date.now, hasOtherPlayers == true {
            return .notStarted(hasOtherPlayer: true)
        }
        return .disabled
    }
}
