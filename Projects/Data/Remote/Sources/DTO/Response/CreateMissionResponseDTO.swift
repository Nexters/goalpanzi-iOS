//
//  CreateMissionResponseDTO.swift
//  DataRemote
//
//  Created by 김용재 on 8/12/24.
//

import Foundation

struct CreateMissionResponseDTO: Decodable {
    let missionId: Int
    let hostMemberId: Int
    let description: String
    let missionStartDate: String
    let missionEndDate: String
    let timeOfDay: String
    let missionDays: [String]
    let boardCount: Int
    let invitationCode: String
    
    init(
        missionId: Int,
        hostMemberId: Int,
        description: String,
        missionStartDate: String,
        missionEndDate: String,
        timeOfDay: String,
        missionDays: [String],
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
}
