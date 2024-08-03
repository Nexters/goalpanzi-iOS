//
//  NetworkProviderType.swift
//  CoreNetworkInterface
//
//  Created by Haeseok Lee on 7/19/24.
//

import Foundation

public protocol NetworkProviderType {
    
    func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N, interceptor: NetworkRequestInterceptor?) async throws -> T where N.Response == T
}
