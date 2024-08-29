//
//  JoinCompetitionRequestDTO.swift
//  DataRemote
//
//  Created by 김용재 on 8/13/24.
//

import Foundation

struct JoinCompetitionRequestDTO: Encodable {
    
    let invitationCode: String
    
    init(invitationCode: String) {
        self.invitationCode = invitationCode
    }
}
