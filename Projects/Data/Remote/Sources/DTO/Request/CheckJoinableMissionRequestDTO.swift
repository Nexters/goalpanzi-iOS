//
//  CheckJoinableMissionRequestDTO.swift
//  DataRemote
//
//  Created by 김용재 on 8/19/24.
//

import Foundation

struct CheckJoinableMissionRequestDTO: Encodable {
    
    let invitationCode: String
    
    init(invitationCode: String) {
        self.invitationCode = invitationCode
    }
}
