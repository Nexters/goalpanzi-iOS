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
    
    public var numberOfRows: Int
    
    public var pieces: Set<Piece>
    
    public var totalBlockCount: Int { blocks.count }
    
    public init(
        theme: any BoardTheme,
        blocks: [Position: Block],
        pieces: Set<Piece>,
        numberOfRows : Int = 3
    ) {
        self.theme = theme
        self.blocks = blocks
        self.pieces = pieces
        self.numberOfRows = numberOfRows
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
        
        let cycle = numberOfRows * 2
        let phase1 = (0...(numberOfRows - 1))
        let phase2 = (numberOfRows...(cycle - 1))
        
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
}
