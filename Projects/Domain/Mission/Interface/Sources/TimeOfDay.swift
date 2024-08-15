//
//  TimeOfDay.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 8/15/24.
//

import Foundation

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
    
    public var startTime: String {
        switch self {
        case .morning, .everyday:
            return "00"
        case .afternoon:
            return "12"
        }
    }
    
    public var endTime: String {
        switch self {
        case .morning:
            return "12"
        case .afternoon, .everyday:
            return "24"
        }
    }
}
