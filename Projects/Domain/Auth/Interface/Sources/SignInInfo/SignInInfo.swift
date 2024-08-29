//
//  SignInInfo.swift
//  DomainAuthInterface
//
//  Created by Haeseok Lee on 7/27/24.
//

import Foundation

public struct SignInInfo {
    public let accessToken: String
    public let refreshToken: String
    public let isProfileSet: Bool
    public let memberId: Int
    
    public init(accessToken: String, refreshToken: String, isProfileSet: Bool, memberId: Int) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.isProfileSet = isProfileSet
        self.memberId = memberId
    }
}
