//
//  GetMissionMembersMeResponseDTO.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/12/24.
//

import Foundation

struct GetMissionMembersMeResponseDTO: Decodable {
    
    struct Profile: Decodable {
        let nickname: String
        let characterType: String
    }
    
    struct Mission: Decodable {
        let missionId: Int
        let description: String
    }
    
    let profile: Profile
    
    let missions: [Mission]
}
