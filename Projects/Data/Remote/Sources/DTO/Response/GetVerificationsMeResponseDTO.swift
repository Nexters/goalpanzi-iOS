//
//  GetVerificationsMeResponseDTO.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation

struct GetVerificationsMeResponseDTO: Decodable {
    let nickname: String
    let characterType: String
    let imageUrl: String
    let verifiedAt: Date?
}
