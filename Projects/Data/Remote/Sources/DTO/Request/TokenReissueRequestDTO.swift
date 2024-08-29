//
//  TokenReissueRequestDTO.swift
//  DataRemote
//
//  Created by Miro on 8/4/24.
//

import Foundation

struct TokenReissueRequestDTO: Encodable {
    let refreshToken: String

    init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
}
