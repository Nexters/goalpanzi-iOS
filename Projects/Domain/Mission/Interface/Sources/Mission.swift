//
//  Mission.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    public var missionPeriodDescription: String {
        "\(dateFormatter.string(from: missionStartDate))~\(dateFormatter.string(from: missionEndDate))"
    }
    
    public var missionWeekDayDescription: String {
        missionDays.map { $0.toKorean }.joined(separator: "/")
    }
    
    public var missionTimeDescription: String {
        timeOfDay.toKorean + " \(timeOfDay.startTimeString)~\(timeOfDay.endTimeString)시"
    }
    
    public var checkIsMissionTime: Bool {
        guard missionDays.contains(todayWeekday) else { return false }
        switch (timeOfDay, isAM(date: Date.now)) {
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
    
    public var todayWeekday: WeekDay {
        let calendar = Calendar.current
        let today = Date()
        let weekdayIndex = calendar.component(.weekday, from: today)
        let weekdays = WeekDay.allCases
        return weekdays[weekdayIndex - 1]
    }
    
    public func isAM(date: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour < 12
    }
}

public enum TimeOfDay: String {
    case morning = "MORNING"
    case afternoon = "AFTERNOON"
    case everyday = "EVERYDAY"
    
    public init?(rawValue: String) {
        switch rawValue {
        case "MORNING":
            self = .morning
        case "AFTERNOON":
            self = .afternoon
        case "EVERYDAY":
            self = .everyday
        default:
            return nil
        }
    }
    
    public var toKorean: String {
        switch self {
        case .morning:
            return "오전"
        case .afternoon:
            return "오후"
        case .everyday:
            return "종일"
        }
    }
    
    public var startTimeString: String {
        switch self {
        case .morning, .everyday:
            return "00시"
        case .afternoon:
            return "12시"
        }
    }
    
    public var endTimeString: String {
        switch self {
        case .morning:
            return "12시"
        case .afternoon, .everyday:
            return "24시"
        }
    }
}

public enum WeekDay: String, CaseIterable {
    case sunday = "SUNDAY"
    case monday = "MONDAY"
    case tuesday = "TUESDAY"
    case wednesday = "WEDNESDAY"
    case thursday = "THURSDAY"
    case friday = "FRIDAY"
    case saturday = "SATURDAY"
    
    public init?(rawValue: String) {
        switch rawValue {
        case "SUNDAY":
            self = .sunday
        case "MONDAY":
            self = .monday
        case "TUESDAY":
            self = .tuesday
        case "WEDNESDAY":
            self = .wednesday
        case "THURSDAY":
            self = .thursday
        case "FRIDAY":
            self = .friday
        case "SATURDAY":
            self = .saturday
        default:
            return nil
        }
    }
    
    public var toKorean: String {
        switch self {
        case .sunday:
            return "일"
        case .monday:
            return "월"
        case .tuesday:
            return "화"
        case .wednesday:
            return "수"
        case .thursday:
            return "목"
        case .friday:
            return "금"
        case .saturday:
            return "토"
        }
    }
}
