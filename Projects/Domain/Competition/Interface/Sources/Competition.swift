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
    
    public let status: Status
    
    public var info: [InfoKey: String]
    
    public var board: Board
    
    public init(
        players: [Player],
        verifications: [Vertification],
        board: Board,
        info: [InfoKey: String] = [:],
        status: Status
    ) {
        self.players = players
        self.verifications = verifications
        self.board = board
        self.info = info
        self.status = status
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
    
    enum InfoKey {
        case title
        case subtitle
    }
    
    enum Status: Equatable {
        case created(hasOtherPlayer: Bool)
        case started
        case deleted
        case pendingCompleted
        case completed
    }
}

public extension MissionStatus {
    
    func toCompetitionStatus(hasOtherPlayer: Bool) -> Competition.Status {
        switch self {
        case .pending, .created:
            return .created(hasOtherPlayer: hasOtherPlayer)
        case .canceled:
            return .deleted
        case .ongoing, .inProgress:
            return .started
        case .deleted:
            return .deleted
        case .pendingCompletion:
            return .pendingCompleted
        case .completed:
            return .completed
        }
    }
}

public extension Mission {
    
    func makeInfos(status: Competition.Status?, progressCount: Int, myRank: Int) -> [Competition.InfoKey: String] {
        switch status {
        case .created, .deleted, nil:
            let formatter = DateFormatter()
            formatter.dateFormat = "경쟁시작 M월 d일"
            return [
                .title: formatter.string(from: startDate),
                .subtitle: "해당일에 자동으로 경쟁이 시작돼요."
            ]
        case .started, .pendingCompleted, .completed:
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
