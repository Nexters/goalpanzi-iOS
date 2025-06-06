//
//  GetMissionHistoriesMeResponseDTO.swift
//  DataRemote
//
//  Created by Haeseok Lee on 6/1/25.
//

import Foundation

struct GetMissionHistoriesMeResponseDTO: Decodable {
    
    struct History: Decodable {
        let missionId: Int
        let description: String
        let missionStartDate: Date
        let missionEndDate: Date
        let myVerificationCount: Int
        let totalVerificationCount: Int
        let rank: Int
        let randomImageUrlList: [String]
        let memberCount: Int
        let missionMembers: [Member]
    }
    
    struct Member: Decodable {
        let memberId: Int
        let nickname: String
        let characterType: String
    }
    
    let totalCount: Int
    let hasNext: Bool
    let resultList: [History]
}
