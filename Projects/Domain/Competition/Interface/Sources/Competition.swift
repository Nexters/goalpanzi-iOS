//
//  Competition.swift
//  DomainCompetitionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import DomainBoardInterface
import DomainPlayerInterface

public struct Competition {
    
    public enum State: Equatable {
        case notStarted(hasOtherPlayer: Bool)
        case started
    }
    
    public var players: [Player]
    
    public var certifications: [PlayerID: Certification]
    
    public var state: State
    
    public var info: [InfoKey: String]
    
    public var board: Board
    
    public init(
        players: [Player],
        board: Board,
        info: [InfoKey: String] = [:],
        state: State
    ) {
        self.players = players
        self.certifications = [:]
        self.board = board
        self.info = info
        self.state = state
        self.certifications = createCertifications(by: players)
        self.board.update(pieces: createPieces(by: players))
    }
    
    public var me: Player? {
        players.first(where: { $0.isMe == true })
    }
    
    public var myPiece: Piece? {
        guard let me else { return nil }
        return board.findPiece(by: me.pieceID)
    }
    
    public func findPlayer(by playerID: PlayerID) -> Player? {
        return players.first(where: { $0.id == playerID })
    }
    
    public func findCertification(by playerID: PlayerID) -> Certification? {
        return certifications[playerID]
    }
    
    public func players(position: Position) -> [Player] {
        return players.filter {
            let piece = board.findPiece(by: $0.pieceID)
            return piece?.position == position
        }
    }
    
    public func representativePiece(by position: Position) -> Piece? {
        let result = board.findPieces(by: position)
        if let myPiece = result.first(where: { $0.id == myPiece?.id }) {
            return myPiece
        }
        return result.first
    }
    
    public mutating func createCertifications(by players: [Player]) -> [PlayerID: Certification] {
        Dictionary(uniqueKeysWithValues: players.map {
            ($0.id, Certification(id: UUID().uuidString, playerID: $0.id))
        })
    }
    
    public mutating func createPieces(by players: [Player]) -> [Position: [Piece]] {
        [Position(index: .zero): players.map { player in
            Piece(
                id: player.pieceID,
                position: .init(index: .zero),
                image: player.character.basicImage,
                name: player.character.koreanName,
                isHighlighted: player.isMe
            )
        }]
    }
    
    public func numberOfPlayers(position: Position) -> Int {
        return players(position: position).count
    }
    
    public mutating func certify(playerID: PlayerID, imageURL: String) {
        certifications[playerID]?.update(imageURL: imageURL)
        if let playerIndex = players.firstIndex(where: { $0.id == playerID }) {
            players[playerIndex].update(isCertificated: true)
        }
    }
    
    public func isCertified(playerID: PlayerID) -> Bool {
        guard let certification = certifications[playerID] else {
            return false
        }
        return certification.isCertified
    }
    
    public mutating func resetCertifications() {
        certifications = certifications.reduce([:]) { partialResult, keyValue in
            var newResult = partialResult
            var (playerID, certification) = keyValue
            certification.reset()
            newResult[playerID] = certification
            return newResult
        }
        for (index, _) in players.enumerated() {
            players[index].update(isCertificated: false)
        }
    }
}

public extension Competition {
    
    enum InfoKey {
        case title
        case subtitle
    }
}
