//
//  Board.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

public struct Board {
    
    public let theme: any BoardTheme
    
    public var blocks: [Position: Block]
    
    public var numberOfColumns: Int
    
    public var numberOfRows: Int {
        Int(ceil((Double(totalBlockCount) / Double(numberOfColumns))))
    }
    
    public var pieces: Set<Piece>
    
    public var events: [Event]
    
    public let totalBlockCount: Int
    
    public var conqueredIndex: Int
    
    public var isDisabled: Bool
    
    public init(
        theme: any BoardTheme,
        events: [Event],
        pieces: Set<Piece>,
        totalBlockCount: Int,
        numberOfColumns : Int = 3,
        conqueredIndex: Int = .zero,
        isDisabled: Bool = false
    ) {
        self.theme = theme
        self.blocks = (0..<totalBlockCount).reduce([:], { partialResult, index in
            var newResult = partialResult
            let position = Position(index: index)
            newResult[position] = Block(
                position: position,
                kind: Self.blockKind(
                    position: position,
                    totalBlockCount: totalBlockCount,
                    numberOfColumns: numberOfColumns
                ),
                theme: theme.blockTheme,
                isLastBlock: index == totalBlockCount - 1,
                isConquered: index <= conqueredIndex,
                isDisabled: isDisabled
            )
            return newResult
        })
        self.pieces = pieces
        self.events = events
        self.totalBlockCount = totalBlockCount
        self.numberOfColumns = numberOfColumns
        self.conqueredIndex = conqueredIndex
        self.isDisabled = isDisabled
    }
    
    public func findBlock(by piece: Piece) -> Block? {
        return findBlock(by: piece.position)
    }
    
    public func findBlock(by position: Position) -> Block? {
        return blocks[position]
    }
    
    public func findPiece(by position: Position) -> Piece? {
        return pieces.first(where: { $0.position == position })
    }
    
    public func findPiece(by pieceID: PieceID) -> Piece? {
        return pieces.first(where: { $0.id == pieceID })
    }
    
    public mutating func move(piece: Piece, to position: Position) -> Direction? {
        
        defer {
            let endIndex = totalBlockCount - 1
            let newPiece = Piece(
                id: piece.id,
                position: Position(index: max(endIndex, position.index + 1))
            )
            pieces.remove(piece)
            pieces.insert(newPiece)
        }
        
        let cycle = numberOfColumns * 2
        let phase1 = (0...(numberOfColumns - 1))
        let phase2 = (numberOfColumns...(cycle - 1))
        
        let departureIndex = piece.position.index
        let arrivalIndex = position.index
        
        guard departureIndex < arrivalIndex else { return nil }
        
        if phase1 ~= departureIndex, phase1 ~= arrivalIndex {
            return .right
        }
        
        if phase1 ~= departureIndex, phase2 ~= arrivalIndex {
            return .down
        }
        
        if phase2 ~= departureIndex, phase2 ~= arrivalIndex {
            return .left
        }
        
        return nil
    }

    public static func blockKind(position: Position, totalBlockCount: Int, numberOfColumns: Int) -> BlockKind {
        
        let isStartIndex = position == .zero
        let isLastIndex = position.index == totalBlockCount - 1
        
        if isStartIndex || isLastIndex {
            return .square
        }
        
        let cycle: Int = (numberOfColumns * 2)
        guard cycle != .zero else { return .square }
        
        if position.index % cycle == numberOfColumns - 1 {
            return .firstQuadrant
        }
        
        if position.index % cycle == numberOfColumns {
            return .fourthQuardrant
        }
        
        if position.index % cycle == cycle - 1 {
            return .secondQuadrant
        }
        
        if position.index % cycle == .zero {
            return .thirdQuadrant
        }
        
        return .square
    }
}
