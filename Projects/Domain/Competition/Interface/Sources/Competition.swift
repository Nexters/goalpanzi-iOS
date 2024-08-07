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
    
    public var players: [Player]
    
    public var certifications: [PlayerID: Certification]
    
    public var info: [InfoKey: String]
    
    public var board: Board
    
    public init(players: [Player], board: Board, info: [InfoKey: String] = [:]) {
        self.players = players
        self.certifications = Dictionary(uniqueKeysWithValues: players.map {
            ($0.id, Certification(id: UUID().uuidString, playerID: $0.id))
        })
        self.board = board
        self.info = info
        self.board.update(pieces: createPieces(by: players))
    }
    
    public func findMe() -> Player? {
        return players.first(where: { $0.isMe == true })
    }
    
    public func findMyPiece() -> Piece? {
        guard let me = findMe() else { return nil }
        return board.findPiece(by: me.pieceID)
    }
    
    public func findPlayer(by playerID: PlayerID) -> Player? {
        return players.first(where: { $0.id == playerID })
    }
    
    public func players(position: Position) -> [Player] {
        return players.filter {
            let piece = board.findPiece(by: $0.pieceID)
            return piece?.position == position
        }
    }
    
    public mutating func createPieces(by players: [Player]) -> Set<Piece> {
        Set(players.map { player in
            Piece(id: player.pieceID, position: .init(index: .zero), image: player.character.basicImage, name: player.character.koreanName)
        })
    }
    
    public func numberOfPlayers(position: Position) -> Int {
        return players(position: position).count
    }
    
    public mutating func certify(playerID: PlayerID, imageURL: String) {
        guard let old = certifications[playerID] else {
            return
        }
        certifications[playerID] = Certification(id: old.id, playerID: old.playerID, imageURL: imageURL, createAt: old.createAt, updatedAt: Date.now)
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
    }
}

public extension Competition {
    
    enum InfoKey {
        case title
        case subtitle
    }
}
