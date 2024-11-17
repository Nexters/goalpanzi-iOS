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
        let missionVerificationId: Int?
        let imageUrl: String
        let verifiedAt: Date?
        let viewedAt: Date?
    }
    
    let missionVerifications: [Verification]
}
