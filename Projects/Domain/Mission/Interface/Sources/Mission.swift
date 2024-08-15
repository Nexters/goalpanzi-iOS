//
//  Mission.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import SharedUtil
import OrderedCollections

public struct Mission: CustomStringConvertible {
    
    public let missionId: Int
    public let hostMemberId: Int
    public let description: String
    public let missionStartDate: Date
    public let missionEndDate: Date
    public let timeOfDay: TimeOfDay
    public let missionDays: [WeekDay]
    public let boardCount: Int
    public let invitationCode: String
    
    public init(
        missionId: Int,
        hostMemberId: Int,
        description: String,
        missionStartDate: Date,
        missionEndDate: Date,
        timeOfDay: TimeOfDay,
        missionDays: [WeekDay],
        boardCount: Int,
        invitationCode: String
    ) {
        self.missionId = missionId
        self.hostMemberId = hostMemberId
        self.description = description
        self.missionStartDate = missionStartDate
        self.missionEndDate = missionEndDate
        self.timeOfDay = timeOfDay
        self.missionDays = missionDays
        self.boardCount = boardCount
        self.invitationCode = invitationCode
    }
    
    public var missionPeriodDescription: String {
        "\(DateFormatter.yearMonthDayFormatter.string(from: missionStartDate))~\(DateFormatter.yearMonthDayFormatter.string(from: missionEndDate))"
    }
    
    public var missionWeekDayDescription: String {
        missionDays.map { $0.toKorean }.joined(separator: "/")
    }
    
    public var missionTimeDescription: String {
        [timeOfDay.toKorean, "\(timeOfDay.startTime)~\(timeOfDay.endTime)시"].joined(separator: " ")
    }
    
    public var checkIsMissionTime: Bool {
        guard missionDays.contains(WeekDay.today) else { return false }
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
