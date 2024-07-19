//
//  Requestable.swift
//  CoreNetworkInterface
//
//  Created by Haeseok Lee on 7/19/24.
//

import Foundation
import Alamofire
import SharedUtil

public protocol Requestable {
    var path: String { get }
    var httpMethod : HTTPMethod { get }
    var queryParameters: Encodable? { get }
    var bodyParameters: Encodable? { get }
    var headers: [String : String]? { get }
}

extension Requestable {
    
    public func makeURLRequest() throws -> URLRequest {
        guard var urlComponent = try makeURLComponents() else {
            throw AFError.createURLRequestFailed(error: NSError())
        }
        
        if let queryItems = try getQueryParameters() {
            urlComponent.queryItems = queryItems
        }
        
        guard let url = urlComponent.url else {
            throw AFError.createURLRequestFailed(error: NSError())
        }
        
        var urlRequest = URLRequest(url: url)
        
        if let bodyParameters, let httpBody = try? JSONEncoder().encode(bodyParameters) {
            urlRequest.httpBody = httpBody
        }
        
        if let headers {
            headers.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
}

private extension Requestable {
    
    func makeURLComponents() throws -> URLComponents? {
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            throw AFError.invalidURL(url: URLComponents())
        }
        return URLComponents(string: baseURL + path)
    }
    
    
    func getQueryParameters() throws -> [URLQueryItem]? {
        guard let queryParameters else {
            return nil
        }
        
        guard let queryDictionary = try? queryParameters.toDictionary() else {
            return nil
        }
        
        var queryItemList : [URLQueryItem] = []
        
        queryDictionary.forEach { (key, value) in
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            queryItemList.append(queryItem)
        }
        
        if queryItemList.isEmpty {
            return nil
        }
        
        return queryItemList
    }
}
