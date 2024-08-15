//
//  WeekDay.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 8/15/24.
//

import Foundation

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
    
    public static var today: Self {
        let weekdayIndex = Calendar.current.component(.weekday, from: Date.now)
        return WeekDay.allCases[weekdayIndex - 1]
    }
}
