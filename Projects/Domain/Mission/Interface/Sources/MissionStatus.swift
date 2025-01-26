//
//  MissionStatus.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 11/14/24.
//

import Foundation

public enum MissionStatus: String {
    case pending = "PENDING"
    case ongoing = "ONGOING"
    case created = "CREATED"
    case canceled = "CANCELED"
    case inProgress = "IN_PROGRESS"
    case deleted = "DELETED"
    case pendingCompletion = "PENDING_COMPLETION"
    case completed = "COMPLETED"
    
    public init?(rawValue: String) {
        switch rawValue {
        case "PENDING":
            self = .pending
        case "ONGOING":
            self = .ongoing
        case "CREATED":
            self = .created
        case "CANCELED":
            self = .canceled
        case "IN_PROGRESS":
            self = .inProgress
        case "DELETED":
            self = .deleted
        case "PENDING_COMPLETION":
            self = .pendingCompletion
        case "COMPLETED":
            self = .completed
        default:
            return nil
        }
    }
}
