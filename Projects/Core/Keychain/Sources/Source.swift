// This is for Tuist

import Foundation
import CoreKeychainInterface // 요거 하면 된다?..

public struct KeychainController: KeychainInterface {

    public static let shared = KeychainController()
    private let service: String = "MissionMate"

    public func create(_ value: String, key: KeychainKey) {
        guard let data = value.data(using: .utf8) else { return }

        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue,
            kSecValueData: data
        ]

        let status = SecItemAdd(query, nil)
        guard status == errSecSuccess else { return }
    }

    public func read(_ key: KeychainKey) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: true
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        guard status != errSecItemNotFound else { return nil }
        guard status == errSecSuccess else { return nil }

        guard let data = result as? Data else { return nil }

        return String(data: data, encoding: .utf8)
    }

    public func update(_ data: Data?, key: KeychainKey) {
        guard let data else { return }

        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue
        ]

        let attributes: NSDictionary = [
            kSecValueData: data
        ]

        let status = SecItemUpdate(query, attributes)
        guard status == errSecSuccess else { return }
    }

    public func delete(_ key: KeychainKey) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue
        ]

        let status = SecItemDelete(query)
        guard status != errSecItemNotFound else { return }
        guard status == errSecSuccess else { return }
    }
}
