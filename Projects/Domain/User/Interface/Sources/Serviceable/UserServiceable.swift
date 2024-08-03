//
//  UserServiceable.swift
//  DomainUser
//
//  Created by Miro on 8/3/24.
//

import Foundation

public protocol UserServiceable {

    var createProfile: @Sendable (_ nickName: String, Character) async throws -> Void { get }
}
