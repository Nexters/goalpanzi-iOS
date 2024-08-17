//
//  Mission.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import SharedUtil
import OrderedCollections

public struct Mission: CustomStringConvertible, Equatable {
    
    public let missionId: Int
    public let hostMemberId: Int
    public let description: String
    public let startDate: Date
    public let endDate: Date
    public let timeOfDay: TimeOfDay
    public let verificationWeekDays: [WeekDay]
    public let verificationDays: Int
    public let invitationCode: String
    
    public init(
        missionId: Int,
        hostMemberId: Int,
        description: String,
        startDate: Date,
        endDate: Date,
        timeOfDay: TimeOfDay,
        verificationWeekDays: [WeekDay],
        verificationDays: Int,
        invitationCode: String
    ) {
        self.missionId = missionId
        self.hostMemberId = hostMemberId
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
        self.timeOfDay = timeOfDay
        self.verificationWeekDays = verificationWeekDays
        self.verificationDays = verificationDays
        self.invitationCode = invitationCode
    }
    
    public var missionPeriodDescription: String {
        "\(DateFormatter.yearMonthDayFormatter.string(from: startDate))~\(DateFormatter.yearMonthDayFormatter.string(from: endDate))"
    }
    
    public var missionWeekDayDescription: String {
        verificationWeekDays.map { $0.toKorean }.joined(separator: "/")
    }
    
    public var missionTimeDescription: String {
        [timeOfDay.toKorean, "\(timeOfDay.startTime)~\(timeOfDay.endTime)시"].joined(separator: " ")
    }
    
    public var checkIsMissionTime: Bool {
        guard verificationWeekDays.contains(WeekDay.today) else { return false }
        switch (timeOfDay, Date.now.isAM) {
        case (.morning, true):
            return true
        case (.morning, false):
            return false
        case (.afternoon, false):
            return true
        case (.afternoon, true):
            return false
        case (.everyday, _):
            return true
        }
    }
    
    public var toInfos: OrderedDictionary<String, String> {
        [
            "미션" : description,
            "미션 기간": missionPeriodDescription,
            "인증 요일": missionWeekDayDescription,
            "인증 시간": missionTimeDescription
        ]
    }
}
