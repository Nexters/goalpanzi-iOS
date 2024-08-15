//
//  CheckProfileResponseDTO.swift
//  DataRemote
//
//  Created by 김용재 on 8/15/24.
//

import Foundation

struct CheckProfileResponseDTO: Decodable {
    let nickname: String
    let characterType: String
    
    init(nickname: String, characterType: String) {
        self.nickname = nickname
        self.characterType = characterType
    }
}
