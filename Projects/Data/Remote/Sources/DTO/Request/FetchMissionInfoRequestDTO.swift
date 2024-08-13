//
//  FetchMissionInfoRequestDTO.swift
//  DataRemote
//
//  Created by 김용재 on 8/13/24.
//

import Foundation

struct FetchMissionInfoRequestDTO: Encodable {
    
    let invitationCode: String
    
    init(invitationCode: String) {
        self.invitationCode = invitationCode
    }
}
