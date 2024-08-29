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
            let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: NetworkRequestInterceptor())
            
            switch response {
                
            case .success(let response):
                KeychainProvider.shared.save(response.accessToken, key: .accessToken)
                KeychainProvider.shared.save(response.refreshToken, key: .refreshToken)
                completion(.retry)

            case .failure(let error):
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
