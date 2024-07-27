//
//  SignInRequestDTO.swift
//  DomainAuth
//
//  Created by 김용재 on 7/26/24.
//

import Foundation

public struct SignInRequestDTO: Encodable {
    public let identityToken: String
    
    public init(identityToken: String) {
        self.identityToken = identityToken
    }
}
