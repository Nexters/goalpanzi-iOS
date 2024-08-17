//
//  Vertification.swift
//  DomainCompetitionInterface
//
//  Created by Haeseok Lee on 8/1/24.
//

import Foundation
import DomainPlayerInterface

public struct Vertification {
    
    public let id: String
    
    public let playerID: PlayerID
    
    public var imageURL: String?
    
    public var isVerified: Bool {
        if imageURL?.isEmpty == true {
            return false
        }
        return imageURL != nil || verifiedAt != nil
    }
    
    public var verifiedAt: Date?
    
    public init(
        id: String,
        playerID: PlayerID,
        imageURL: String? = nil,
        verifiedAt: Date? = nil
    ) {
        self.id = id
        self.playerID = playerID
        self.imageURL = imageURL
        self.verifiedAt = verifiedAt
    }
    
    public mutating func update(imageURL: String, verifiedAt: Date?) {
        self.imageURL = imageURL
        self.verifiedAt = verifiedAt
    }
}
