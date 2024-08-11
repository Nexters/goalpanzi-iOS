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
    
    public private(set) var pieces: [Position: [Piece]]
    
    public var events: [Event]
    
    public let totalBlockCount: Int
    
    public var conqueredPosition: Position
    
    public var isDisabled: Bool
    
    public init(
        theme: any BoardTheme,
        events: [Event],
        totalBlockCount: Int,
        numberOfColumns : Int = 3,
        conqueredPosition: Position = .zero,
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
                    numberOfColumns: numberOfColumns
                ),
                theme: theme.blockTheme,
                isLastBlock: index == totalBlockCount - 1,
                isConquered: index <= conqueredPosition.index,
                isDisabled: isDisabled
            )
            return newResult
        })
        self.events = events
        self.totalBlockCount = totalBlockCount
        self.numberOfColumns = numberOfColumns
        self.conqueredPosition = conqueredPosition
        self.isDisabled = isDisabled
        self.pieces = .init()
    }
    
    public func findBlock(by piece: Piece) -> Block? {
        return findBlock(by: piece.position)
    }
    
    public func findBlock(by position: Position) -> Block? {
        return blocks[position]
    }
    
    public func findPieces(by position: Position) -> [Piece] {
        return pieces[position] ?? []
    }
    
    public func findPiece(by pieceID: PieceID) -> Piece? {
        return pieces.flatMap(\.value).first(where: { $0.id == pieceID })
    }
    
    public func findEvent(by position: Position) -> Event? {
        return events.first(where: { $0.position == position })
    }
    
    public mutating func update(pieces: [Position: [Piece]]) {
        self.pieces = pieces
    }
    
    public mutating func update(piece: Piece) {
        if pieces[piece.position] == nil {
            pieces[piece.position] = []
        }
        pieces[piece.position]?.append(piece)
    }
    
    public mutating func update(piece: Piece, to position: Position) {
        remove(piece: piece)
        update(piece: Piece(id: piece.id, position: position, image: piece.image, name: piece.name, isHighlighted: piece.isHighlighted))
    }
    
    public mutating func remove(piece: Piece) {
        let samePositionPieces = pieces[piece.position]
        guard let pieceIndex = samePositionPieces?.firstIndex(of: piece) else { return }
        pieces[piece.position]?.remove(at: pieceIndex)
    }
    
    public mutating func update(conqueredPosition: Position) {
        self.conqueredPosition = conqueredPosition
        self.blocks = blocks.reduce([:], { partialResult, keyValue in
            var newResult = partialResult
            var (position, block) = keyValue
            block.isConquered = block.position.index <= conqueredPosition.index
            newResult[position] = block
            return newResult
        })
    }
    
    public func move(piece: Piece, to position: Position) -> Direction? {
        
        defer {
//            let endIndex = totalBlockCount - 1
//            let newPiece = Piece(
//                id: piece.id,
//                position: Position(index: max(endIndex, position.index + 1)),
//                image: piece.image,
//                name: piece.name
//            )
//            pieces.remove(piece)
//            pieces.insert(newPiece)
        }
        
        let cycle = numberOfColumns * 2
        let phase1 = (0...(numberOfColumns - 1))
        let phase2 = (numberOfColumns...(cycle - 1))
        
        let departureIndex = piece.position.index % cycle
        let arrivalIndex = position.index % cycle
        
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

    public static func blockKind(position: Position, numberOfColumns: Int) -> BlockKind {
        
        let isStartIndex = position == .zero
        
        if isStartIndex {
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
