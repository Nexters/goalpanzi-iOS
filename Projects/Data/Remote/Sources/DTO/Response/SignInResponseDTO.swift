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
    let isProfileSet: Bool
    
    init(accessToken: String, refreshToken: String, isProfileSet: Bool) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.isProfileSet = isProfileSet
    }
}
