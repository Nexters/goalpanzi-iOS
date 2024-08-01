//
//  Position.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

public struct Position: Hashable {
    
    public static let zero: Self = .init(index: 0)
    
    public let index: Int
    
    public init(index: Int) {
        self.index = index
    }
}
