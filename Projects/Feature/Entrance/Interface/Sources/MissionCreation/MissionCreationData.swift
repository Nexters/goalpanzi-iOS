//
//  MissionCreationData.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/10/24.
//

import Foundation

struct MissionCreationData: Equatable {
    var description: String  = ""
    var startDate: Date = Date()
    var endDate: Date = Date()
    var timeOfDay: TimeOfDay = .afternoon
    var authenticationWeekDays: [Weekday]  = []
    var authenticationDays: Int = 0

}
