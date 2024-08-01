//
//  Certification.swift
//  DomainCompetitionInterface
//
//  Created by Haeseok Lee on 8/1/24.
//

import Foundation
import DomainPlayerInterface

public struct Certification {
    
    public let id: String
    
    public let playerID: PlayerID
    
    public var imageURL: String?
    
    public var isCertified: Bool {
        imageURL != nil
    }
    
    public var createAt: Date?
    
    public var updatedAt: Date?
    
    public init(
        id: String,
        playerID: PlayerID,
        imageURL: String? = nil,
        createAt: Date? = Date.now,
        updatedAt: Date? = Date.now
    ) {
        self.id = id
        self.playerID = playerID
        self.imageURL = imageURL
        self.createAt = createAt
        self.updatedAt = updatedAt
    }
    
    public mutating func reset() {
        updatedAt = Date.now
        imageURL = nil
    }
}
