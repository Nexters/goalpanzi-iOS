//
//  NetworkProviderType.swift
//  CoreNetworkInterface
//
//  Created by Haeseok Lee on 7/19/24.
//

import Foundation
import Alamofire

public protocol NetworkProviderType {
    
    func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N, decoder: JSONDecoder, interceptor: NetworkRequestInterceptor?) async throws -> T where N.Response == T
    
    func upload(url: String, imageName: String, imageJPEGData: Data, interceptor: NetworkRequestInterceptor?) async throws -> Empty
}

public extension NetworkProviderType {
    
    func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N, decoder: JSONDecoder = .init(), interceptor: NetworkRequestInterceptor?) async throws -> T where N.Response == T {
        try await sendRequest(endpoint, decoder: decoder, interceptor: interceptor)
    }
    
}
