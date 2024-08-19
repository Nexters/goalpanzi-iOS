//
//  CheckJoinableMissionResponseDTO.swift
//  DataRemote
//
//  Created by 김용재 on 8/19/24.
//

import Foundation

struct CheckJoinableMissionResponseDTO: Decodable {
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
