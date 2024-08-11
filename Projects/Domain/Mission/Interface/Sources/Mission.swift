//
//  Mission.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

public struct Mission: CustomStringConvertible {
    
    public let missionId: Int
    public let hostMemeverId: Int
    public let description: String
    public let missionStartDate: Date
    public let missionEndDate: Date
    public let timeOfDay: String
    public let missionDays: [String]
    public let boardCount: Int
    public let invitationCode: String
    
    public init(
        missionId: Int,
        hostMemeverId: Int,
        description: String,
        missionStartDate: Date,
        missionEndDate: Date,
        timeOfDay: String,
        missionDays: [String],
        boardCount: Int,
        invitationCode: String
    ) {
        self.missionId = missionId
        self.hostMemeverId = hostMemeverId
        self.description = description
        self.missionStartDate = missionStartDate
        self.missionEndDate = missionEndDate
        self.timeOfDay = timeOfDay
        self.missionDays = missionDays
        self.boardCount = boardCount
        self.invitationCode = invitationCode
    }
}
