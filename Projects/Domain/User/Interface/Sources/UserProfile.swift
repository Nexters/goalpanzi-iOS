//
//  UserProfile.swift
//  DomainUserInterface
//
//  Created by 김용재 on 8/15/24.
//

import Foundation

import SharedDesignSystem

public struct UserProfile {
    public let nickname: String
    public let character: Character
    
    public init(nickname: String, character: Character) {
        self.nickname = nickname
        self.character = character
    }
}
