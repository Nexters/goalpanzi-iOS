//
//  AppleLoginController.swift
//  DomainAuthInterface
//
//  Created by Miro on 7/20/24.
//

import Foundation

import AuthenticationServices
import DomainAuthInterface

enum AppleLoginError: LocalizedError {
    case invalidCredential
    case invalidIdentityToken
    case invalidAuthorizationCode
    case transferError(Error)
}

final class AppleLoginController: NSObject, ASAuthorizationControllerDelegate {

    private var continuation: CheckedContinuation<AppleLoginInfomation, Error>?

    func login() async throws -> AppleLoginInfomation {
        try await withCheckedThrowingContinuation { continuation in
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
//            request.nonce = "goalpanzi_\(calculate())"

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()

            if self.continuation == nil {
                self.continuation = continuation
            }
        }
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            continuation?.resume(throwing: AppleLoginError.invalidCredential)
            continuation = nil
            return
        }

        let email = credential.email
        let fullName = credential.fullName

        guard let tokenData = credential.identityToken,
              let token = String(data: tokenData, encoding: .utf8) else {
            continuation?.resume(throwing: AppleLoginError.invalidIdentityToken)
            continuation = nil
            return
        }

        guard let authorizationCode = credential.authorizationCode,
              let codeString = String(data: authorizationCode, encoding: .utf8) else {
            continuation?.resume(throwing: AppleLoginError.invalidAuthorizationCode)
            continuation = nil
            return
        }

        let information = AppleLoginInfomation(identityToken: token)
        continuation?.resume(returning: information)
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
