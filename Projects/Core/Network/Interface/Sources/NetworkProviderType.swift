//
//  NetworkProviderType.swift
//  CoreNetworkInterface
//
//  Created by Haeseok Lee on 7/19/24.
//

import Foundation
import SharedUtilInterface
import Alamofire

public protocol NetworkProviderType {
    
    func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N, decoder: JSONDecoder, interceptor: NetworkRequestInterceptor?) async -> Result<T, ErrorResponse> where N.Response == T
    
    func upload(url: String, imageName: String, imageJPEGData: Data, interceptor: NetworkRequestInterceptor?) async throws -> Empty
}

public extension NetworkProviderType {
    
    func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N, decoder: JSONDecoder = .jsonDecoder, interceptor: NetworkRequestInterceptor?) async -> Result<T, ErrorResponse> where N.Response == T {
        await sendRequest(endpoint, decoder: decoder, interceptor: interceptor)
    }
    
}
