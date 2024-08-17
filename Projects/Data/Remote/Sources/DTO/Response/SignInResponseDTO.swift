//
//  SignInResponseDTO.swift
//  DomainAuth
//
//  Created by 김용재 on 7/26/24.
//

import Foundation

struct SignInResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let nickname: String?
    let characterType: String?
    let isProfileSet: Bool
    let memberId: Int
    
    init(accessToken: String, refreshToken: String, nickname: String?, characterType: String?, isProfileSet: Bool, memberId: Int) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.nickname = nickname
        self.characterType = characterType
        self.isProfileSet = isProfileSet
        self.memberId = memberId
    }
}
