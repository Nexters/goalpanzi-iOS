//
//  Weekday.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/7/24.
//

import Foundation

enum Weekday: String, CaseIterable {
    case monday = "MONDAY"
    case tuesday = "TUESDAY"
    case wednesday = "WEDNESDAY"
    case thursday = "THURSDAY"
    case friday = "FRIDAY"
    case saturday = "SATURDAY"
    case sunday = "SUNDAY"

    var koreanName: String {
        switch self {
        case .monday: return "월"
        case .tuesday: return "화"
        case .wednesday: return "수"
        case .thursday: return "목"
        case .friday: return "금"
        case .saturday: return "토"
        case .sunday: return "일"
        }
    }
}
