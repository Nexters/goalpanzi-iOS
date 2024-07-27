//
//  Source.swift
//  DataRemoteInterface
//
//  Created by Haeseok Lee on 7/28/24.
//

import Foundation
import DomainAuthInterface

public struct AppleAuthService: AppleAuthServiceable {
    
    public var signIn: @Sendable () async throws -> SignInInfo
    
    public init(signIn: @escaping @Sendable () async throws -> SignInInfo) {
        self.signIn = signIn
    }
}
