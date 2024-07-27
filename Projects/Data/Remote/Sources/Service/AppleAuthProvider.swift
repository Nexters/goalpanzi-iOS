//
//  AppleAuthProvider.swift
//  DataRemote
//
//  Created by Haeseok Lee on 7/28/24.
//

import Foundation
import AuthenticationServices

final class AppleAuthProvider: NSObject {
    
    typealias IdentityToken = String
    
    func signIn() async throws -> IdentityToken {
        try await withCheckedThrowingContinuation { continuation in
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            let formattedDate = Date().formattedString(dateFormat: .compactYearMonthDateTime)
            
            request.requestedScopes = [.fullName, .email]
            request.nonce = "goalpanzi_\(formattedDate)"

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()

            if self.continuation == nil {
                self.continuation = continuation
            }
        }
    }
    
    // MARK: Private
    private var continuation: CheckedContinuation<IdentityToken, Error>?
    
    private func getCurrentTimeString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter.string(from: date)
    }
}

private extension AppleAuthProvider {
    
    enum AppleLoginError: LocalizedError {
        case invalidCredential
        case invalidIdentityToken
        case invalidAuthorizationCode
        case transferError(Error)
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleAuthProvider: ASAuthorizationControllerDelegate {
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            continuation?.resume(throwing: AppleLoginError.invalidCredential)
            continuation = nil
            return
        }

        guard let tokenData = credential.identityToken,
              let token = IdentityToken(data: tokenData, encoding: .utf8) else {
            continuation?.resume(throwing: AppleLoginError.invalidIdentityToken)
            continuation = nil
            return
        }

        guard let authorizationCode = credential.authorizationCode,
              let _ = String(data: authorizationCode, encoding: .utf8) else {
            continuation?.resume(throwing: AppleLoginError.invalidAuthorizationCode)
            continuation = nil
            return
        }

        continuation?.resume(returning: token)
        continuation = nil
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
}
