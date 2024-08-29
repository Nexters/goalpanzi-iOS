//
//  CreateMissionRequestDTO.swift
//  DataRemote
//
//  Created by 김용재 on 8/12/24.
//

import Foundation

struct CreateMissionRequestDTO: Encodable {
    let description: String
    let missionStartDate: String
    let missionEndDate: String
    let timeOfDay: String
    let missionDays: [String]
    let boardCount: Int
    
    init(
        description: String,
        missionStartDate: String,
        missionEndDate: String,
        timeOfDay: String,
        missionDays: [String],
        boardCount: Int
    ) {
        self.description = description
        self.missionStartDate = missionStartDate
        self.missionEndDate = missionEndDate
        self.timeOfDay = timeOfDay
        self.missionDays = missionDays
        self.boardCount = boardCount
    }
}
