// This is for Tuist

import Foundation

public enum KeychainKey: String {
    case accessToken
    case refreshToken
}

public struct KeychainProvider {

    public static let shared = KeychainProvider()
    private let service: String = "MissionMate"

    private init() {}

    public func save(_ value: String, key: KeychainKey) {
        let data = value.data(using: .utf8)
        if let _ = self.read(key) {
            self.update(data, key: key)
            return
        }
        self.create(value, key:key)
    }

    private func create(_ value: String, key: KeychainKey) {
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

        guard status != errSecItemNotFound,
              status == errSecSuccess,
              let data = result as? Data
        else { return nil }

        return String(data: data, encoding: .utf8)
    }

    private func update(_ data: Data?, key: KeychainKey) {
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

        guard status != errSecItemNotFound,
              status == errSecSuccess
        else { return }
    }
}

