//
//  TimeOfDay.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/8/24.
//

import Foundation

enum TimeOfDay: String, CaseIterable {
    case morning = "MORNING"
    case afternoon = "AFTERNOON"
    case everyday = "EVERYDAY"

    var description: String {
        switch self {
        case .morning: "오전\n 00~12시"
        case .afternoon: "오후\n 12~00시"
        case .everyday: "종일\n 00~00시"
        }
    }
}
