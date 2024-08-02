//
//  CreatProfileRequestDTO.swift
//  DomainUser
//
//  Created by 김용재 on 8/2/24.
//

import Foundation

struct CreatProfileRequestDTO: Encodable {
    let nickname: String
    let characterType: String
    
    init(nickname: String, characterType: String) {
        self.nickname = nickname
        self.characterType = characterType
    }
}
