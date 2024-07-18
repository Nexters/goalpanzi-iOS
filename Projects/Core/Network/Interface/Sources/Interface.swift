//
//  UtilInterface.swift
//  AppManifests
//
//  Created by Haeseok Lee on 7/16/24.
//
import Foundation
import Alamofire

extension Encodable  {
    public func toDictionary() throws -> [String : Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        return jsonObject as? [String : Any]
    }
}


public protocol Networkable: Requestable, Responsable { }

public protocol Requestable {
    var path: String { get }
    var httpMethod : HTTPMethod { get }
    var queryParameters: Encodable? { get }
    var bodyParameters: Encodable? { get }
    var headers: [String : String]? { get }
}

extension Requestable {
    
    private func makeURLComponents() throws -> URLComponents? {
//        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
//            throw NSError()
//        }
        let baseURL = ""
        return URLComponents(string: baseURL + path)
    }
    
    
    private func getQueryParameters() throws -> [URLQueryItem]? {
        guard let queryParameters else {
            return nil
        }
        
        guard let queryDictionary = try? queryParameters.toDictionary() else {
            throw NSError()
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
    
    public func makeURLRequest() throws -> URLRequest {
        guard var urlComponent = try makeURLComponents() else {
            throw NSError()
        }
        
        if let queryItems = try getQueryParameters() {
            urlComponent.queryItems = queryItems
        }
        
        guard let url = urlComponent.url else {
            throw NSError()
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

public protocol Responsable {
    associatedtype Response
}

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


public protocol NetworkProviderType {
    
    func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N) async throws -> T where N.Response == T
}

public struct NetworkProvider: NetworkProviderType {
    
    public static let shared: NetworkProviderType = NetworkProvider()
    
    public func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N) async throws -> T where N.Response == T {
        let urlRequest: URLRequest = try endpoint.makeURLRequest()
        let dataTask = AF.request(urlRequest).validate().serializingDecodable(T.self)
        print(dataTask)
        print(await dataTask.result)
        print((await dataTask.response).response?.statusCode)
        return try await dataTask.value
    }
    
    private init() {}
}
