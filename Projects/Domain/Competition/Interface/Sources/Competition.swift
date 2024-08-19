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
    
    public var isMeVerified: Bool {
        guard let me else { return false }
        return findVerification(by: me.id)?.isVerified == true
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
        if endDate <= Date.now {
            return .finished
        }
        if startDate <= Date.now, hasOtherPlayers == false {
            return .disabled
        }
        if startDate <= Date.now, hasOtherPlayers == true {
            return .started
        }
        if startDate > Date.now, hasOtherPlayers == false {
            return .notStarted(hasOtherPlayer: false)
        }
        if startDate > Date.now, hasOtherPlayers == true {
            return .notStarted(hasOtherPlayer: true)
        }
        return .disabled
    }
    
    func makeInfos(competitionState state: Competition.State, progressCount: Int, myRank: Int) -> [Competition.InfoKey: String] {
        switch state {
        case .notStarted, .disabled, .finished:
            let formatter = DateFormatter()
            formatter.dateFormat = "경쟁시작 M월 d일"
            return [
                .title: formatter.string(from: startDate),
                .subtitle: "해당일에 자동으로 경쟁이 시작돼요."
            ]
        case .started:
            if !checkIsMissionDay || !checkIsMissionTime {
                return [
                    .title: "꾸준하게 완수해봐요!",
                    .subtitle: "나의 꾸준함 순위는? \(myRank)등"
                ]
            }
            return [
                .title: "오늘 \(progressCount)명이 1칸 이동",
                .subtitle: "나의 꾸준함 순위는? \(myRank)등"
            ]
        }
    }
}
