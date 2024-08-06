//
//  AppleAuthServiceable.swift
//  DomainAuthInterface
//
//  Created by Haeseok Lee on 7/27/24.
//

import Foundation

public protocol AppleAuthServiceable {

    var signIn: @Sendable () async throws -> SignInInfo { get }
}
