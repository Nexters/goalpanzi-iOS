//
//  VerificationViewRequestDTO.swift
//  DataRemote
//
//  Created by Haeseok Lee on 11/17/24.
//

import Foundation

struct VerificationViewRequestDTO: Encodable {
    let missionVerificationId: Int
    
    init(missionVerificationId: Int) {
        self.missionVerificationId = missionVerificationId
    }
}
