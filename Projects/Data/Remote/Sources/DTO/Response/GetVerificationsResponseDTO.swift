//
//  GetVerificationsResponseDTO.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation

struct GetVerificationsResponseDTO: Decodable {
    
    struct Verification: Decodable {
        let nickname: String
        let characterType: String
        let imageUrl: String
        let verifiedAt: Date?
    }
    
    let missionVerifications: [Verification]
}
