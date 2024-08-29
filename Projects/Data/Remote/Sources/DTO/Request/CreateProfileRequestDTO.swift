//
//  CreateProfileRequestDTO.swift
//  DataRemoteInterface
//
//  Created by Miro on 8/3/24.
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
