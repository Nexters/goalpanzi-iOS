//
//  AuthInterceptor.swift
//  DataRemoteInterface
//
//  Created by Miro on 8/3/24.
//

import Foundation

import CoreNetworkInterface
import CoreKeychainInterface

import Alamofire

final class AuthInterceptor: NetworkRequestInterceptor {

    override func reissueTokens(completion: @escaping (RetryResult) -> Void) {
        guard let refreshToken = KeychainProvider.shared.read(.refreshToken) else { return }

        let endPoint = Endpoint<TokenReissueResponseDTO>(
            path: "api/auth/token:reissue", httpMethod: .post, bodyParameters: TokenReissueRequestDTO(refreshToken: refreshToken))
        Task {
            do {
                let response = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: nil)

                KeychainProvider.shared.save(response.accessToken, key: .accessToken)
                KeychainProvider.shared.save(response.refreshToken, key: .refreshToken)

                completion(.retry)
            } catch {
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
