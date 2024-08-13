//
//  AuthInterceptor.swift
//  CoreNetwork
//
//  Created by Miro on 8/3/24.
//

import Foundation
import Alamofire
import CoreKeychainInterface

open class NetworkRequestInterceptor: RequestInterceptor {

    public init () {}

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var urlRequest = urlRequest

//        guard let accessToken = KeychainProvider.shared.read(.accessToken) else {
//            completion(.success(urlRequest))
//            return
//        }

        urlRequest.headers.add(.authorization(bearerToken: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMSIsImlhdCI6MTcyMzU1NDE0MSwiZXhwIjoxNzIzNjQwNTQxfQ.Gm05bYTIMsPjpUrvRv8gCVUHEnHAsKYm2OjhS5jM6p4"))
        completion(.success(urlRequest))
    }

    public func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        self.reissueTokens(completion: completion)
    }

    open func reissueTokens(completion: @escaping (RetryResult) -> Void) {}
}
