// This is for Tuist

import Foundation

public enum KeychainKey: String {
    case accessToken
    case refreshToken
}

public protocol KeychainInterface {
    func create(_ value: String, key: KeychainKey)
    func read(_ key: KeychainKey) -> String?
    func update(_ data: Data?, key: KeychainKey)
}
