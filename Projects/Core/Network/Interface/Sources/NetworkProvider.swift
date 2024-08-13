//
//  NetworkProvider.swift
//  CoreNetworkInterface
//
//  Created by Haeseok Lee on 7/19/24.
//

import Foundation
import Alamofire

struct ErrorResponse: Error, Decodable {
    let code: Int
    let message: String
}

public struct NetworkProvider: NetworkProviderType {
    
    public static let shared: NetworkProviderType = NetworkProvider()

    public func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N, interceptor: NetworkRequestInterceptor? = nil) async throws -> T where N.Response == T {
        let urlRequest: URLRequest = try endpoint.makeURLRequest()

        let dataTask = AF.request(urlRequest, interceptor: interceptor)
            .validate()
            .serializingDecodable(T.self, emptyResponseCodes: [200])

        #if DEBUG
        let response = try await dataTask.response
        if let httpResponse = response.response, !(200..<300).contains(httpResponse.statusCode) {
            if let errorData = response.data {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: errorData)
                    print("Error Code: \(errorResponse.code), Message: \(errorResponse.message)")
                } catch {
                    print("Failed to decode error response: \(error)")
                }
            }
        }
        #endif
        
        return try await dataTask.value
    }

    private init() {}
}
