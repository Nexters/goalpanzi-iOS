//
//  GetMissionResponseDTO.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation

struct GetMissionResponseDTO: Decodable {
    let missionId: Int
    let hostMemberId: Int
    let description: String
    let missionStartDate: Date
    let missionEndDate: Date
    let timeOfDay: String
    let missionDays: [String]
    let boardCount: Int
    let invitationCode: String
}
