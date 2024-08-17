//
//  MissionCreationData.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/10/24.
//

import Foundation

import DomainMissionInterface

public struct MissionCreationData: Equatable {
    
    public init() {}
    
    var description: String  = ""
    var startDate: Date = Date()
    var endDate: Date = Date()
    var timeOfDay: TimeOfDay = .afternoon
    var verificationWeekDays: [WeekDay]  = []
    var verificationDays: Int = 0
}
