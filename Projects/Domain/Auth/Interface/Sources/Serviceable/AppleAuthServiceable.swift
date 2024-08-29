//
//  AppleAuthServiceable.swift
//  DomainAuthInterface
//
//  Created by Haeseok Lee on 7/27/24.
//

import Foundation

public protocol AppleAuthServiceable {

    var signIn: @Sendable () async throws -> SignInInfo { get }
    var logout: @Sendable () async throws -> Void { get }
}
