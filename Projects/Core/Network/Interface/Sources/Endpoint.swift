//
//  Endpoint.swift
//  CoreNetworkInterface
//
//  Created by Haeseok Lee on 7/19/24.
//

import Foundation
import Alamofire

public struct Endpoint<R>: Networkable {
    
    public typealias Response = R
    
    public var path: String
    public var httpMethod: HTTPMethod
    public var queryParameters: Encodable?
    public var bodyParameters: Encodable?
    public var headers: [String : String]?
    
    public init(path: String,
                httpMethod: HTTPMethod,
                queryParameters: Encodable? = nil,
                bodyParameters : Encodable? = nil,
                headers: [String : String]? = nil
    ) {
        self.path = path
        self.httpMethod = httpMethod
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
    }
}
