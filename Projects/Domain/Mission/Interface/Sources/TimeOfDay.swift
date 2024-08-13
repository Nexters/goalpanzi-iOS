//
//  TimeOfDay.swift
//  DomainMission
//
//  Created by 김용재 on 8/12/24.
//

import Foundation

import Foundation

public enum TimeOfDay: String, CaseIterable {
    case morning = "MORNING"
    case afternoon = "AFTERNOON"
    case everyday = "EVERYDAY"

    public var description: String {
        switch self {
        case .morning: "오전 00~12시"
        case .afternoon: "오후 12~00시"
        case .everyday: "종일 00~00시"
        }
    }
}
