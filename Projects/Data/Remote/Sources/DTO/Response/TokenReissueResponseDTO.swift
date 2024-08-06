//
//  TokenReissueResponseDTO.swift
//  DataRemote
//
//  Created by Miro on 8/4/24.
//

import Foundation

struct TokenReissueResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String

    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
