//
//  AuthInterceptor.swift
//  DataRemoteInterface
//
//  Created by Miro on 8/3/24.
//

import Foundation

import CoreNetworkInterface
import CoreKeychainInterface
import SharedUtilInterface
import Alamofire

final class AuthInterceptor: NetworkRequestInterceptor {

    override func reissueTokens(completion: @escaping (RetryResult) -> Void) {
        guard let refreshToken = KeychainProvider.shared.read(.refreshToken) else {
            completion(.doNotRetry)
            return
        }

        let endPoint = Endpoint<TokenReissueResponseDTO>(
            path: "api/auth/token:reissue", httpMethod: .post, bodyParameters: TokenReissueRequestDTO(refreshToken: refreshToken))
        Task {
            do {
                let response = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: NetworkRequestInterceptor())

                KeychainProvider.shared.save(response.accessToken, key: .accessToken)
                KeychainProvider.shared.save(response.refreshToken, key: .refreshToken)

                completion(.retry)
            } catch {
                self.deleteAllTokens()
                NotificationCenter.default.post(name: .didFailTokenRefreshing, object: nil, userInfo: nil)
                completion(.doNotRetryWithError(error))
            }
        }
    }

    private func deleteAllTokens() {
        KeychainProvider.shared.delete(.accessToken)
        KeychainProvider.shared.delete(.refreshToken)
    }
}
