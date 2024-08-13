//
//  Mission.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import DomainBoardInterface
import DomainCompetitionInterface

public struct Mission: Equatable {
    
    public let missionId: Int
    public let description: String
    public let startDate: Date
    public let endDate: Date
    public let timeOfDay: TimeOfDay
    public let authenticationWeekDays: [Weekday]
    public let authenticationDays: Int
    public let invitationCode: String
    
    public init(
        missionId: Int,
        description: String,
        startDate: Date,
        endDate: Date,
        timeOfDay: TimeOfDay,
        authenticationWeekDays: [Weekday],
        authenticationDays: Int,
        invitationCode: String
    ) {
        self.missionId = missionId
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
        self.timeOfDay = timeOfDay
        self.authenticationWeekDays = authenticationWeekDays
        self.authenticationDays = authenticationDays
        self.invitationCode = invitationCode
    }
}
