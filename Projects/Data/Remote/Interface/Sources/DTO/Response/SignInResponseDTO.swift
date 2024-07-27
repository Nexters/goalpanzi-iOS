//
//  SignInResponseDTO.swift
//  DomainAuth
//
//  Created by 김용재 on 7/26/24.
//

import Foundation

public struct SignInResponseDTO: Decodable {
    public let accessToken: String
    public let refreshToken: String
    public let isProfileSet: Bool
    
    public init(accessToken: String, refreshToken: String, isProfileSet: Bool) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.isProfileSet = isProfileSet
    }
}
