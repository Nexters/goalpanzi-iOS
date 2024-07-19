//
//  NetworkProvider.swift
//  CoreNetworkInterface
//
//  Created by Haeseok Lee on 7/19/24.
//

import Foundation
import Alamofire

public struct NetworkProvider: NetworkProviderType {
    
    public static let shared: NetworkProviderType = NetworkProvider()
    
    public func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N) async throws -> T where N.Response == T {
        let urlRequest: URLRequest = try endpoint.makeURLRequest()
        let dataTask = AF.request(urlRequest).validate().serializingDecodable(T.self)
        return try await dataTask.value
    }
    
    private init() {}
}
