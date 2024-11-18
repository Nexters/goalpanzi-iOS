//
//  Vertification.swift
//  DomainCompetitionInterface
//
//  Created by Haeseok Lee on 8/1/24.
//

import Foundation
import DomainPlayerInterface

public struct Vertification {
    
    public let id: Int?
    
    public let playerID: PlayerID
    
    public var imageURL: String?
    
    public var isVerified: Bool {
        if imageURL?.isEmpty == true {
            return false
        }
        return imageURL != nil || verifiedAt != nil
    }
    
    public var isViewed: Bool {
        viewedAt != nil
    }
    
    public var verifiedAt: Date?
    
    public var viewedAt: Date?
    
    public init(
        id: Int?,
        playerID: PlayerID,
        imageURL: String? = nil,
        verifiedAt: Date? = nil,
        viewedAt: Date? = nil
    ) {
        self.id = id
        self.playerID = playerID
        self.imageURL = imageURL
        self.verifiedAt = verifiedAt
        self.viewedAt = viewedAt
    }
    
    public mutating func update(imageURL: String, verifiedAt: Date?) {
        self.imageURL = imageURL
        self.verifiedAt = verifiedAt
    }
}
