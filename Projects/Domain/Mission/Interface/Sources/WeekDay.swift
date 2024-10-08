//
//  WeekDay.swift
//  DomainMission
//
//  Created by 김용재 on 8/12/24.

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
    
    public init?(index: Int) {
        switch index {
        case 1:
            self = .sunday
        case 2:
            self = .monday
        case 3:
            self = .tuesday
        case 4:
            self = .wednesday
        case 5:
            self = .thursday
        case 6:
            self = .friday
        case 7:
            self = .saturday
        default:
            return nil
        }
    }
    
    public var toPriority: Int {
        switch self {
        case .monday:
            return 100
        case .tuesday:
            return 101
        case .wednesday:
            return 102
        case .thursday:
            return 103
        case .friday:
            return 104
        case .saturday:
            return 105
        case .sunday:
            return 106
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

    public static var allCasesInKoreanOrdered: [WeekDay] {
        var weekDays = WeekDay.allCases
        weekDays.remove(at: 0)
        weekDays.append(.sunday)

        return weekDays
    }
}
