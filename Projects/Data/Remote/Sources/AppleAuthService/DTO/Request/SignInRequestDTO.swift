//
//  SignInRequestDTO.swift
//  DomainAuth
//
//  Created by 김용재 on 7/26/24.
//

import Foundation

struct SignInRequestDTO: Encodable {
    let identityToken: String
    
    init(identityToken: String) {
        self.identityToken = identityToken
    }
}
