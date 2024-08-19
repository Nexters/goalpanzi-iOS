//
//  NetworkProvider.swift
//  CoreNetworkInterface
//
//  Created by Haeseok Lee on 7/19/24.
//

import Foundation
import Alamofire

public struct ErrorResponse: Error, Decodable {
    let code: Int
    public let message: String
}

public struct NetworkProvider: NetworkProviderType {
    
    public static let shared: NetworkProviderType = NetworkProvider()

    public func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N, decoder: JSONDecoder = .init(), interceptor: NetworkRequestInterceptor? = nil) async -> Result<T, ErrorResponse> where N.Response == T {
        do {
                let urlRequest: URLRequest = try endpoint.makeURLRequest()

                let dataTask = AF.request(urlRequest, interceptor: interceptor)
                    .validate()
                    .serializingDecodable(T.self, decoder: decoder, emptyResponseCodes: [200])

                let response = await dataTask.response
                
                if let httpResponse = response.response, !(200..<300).contains(httpResponse.statusCode) {
                    if let errorData = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: errorData)
                            return .failure(errorResponse)
                        } catch {
                            let decodingError = ErrorResponse(code: httpResponse.statusCode, message: "Error Decoding occurred")
                            return .failure(decodingError)
                        }
                    }
                }
                
                let value = try await dataTask.value
                return .success(value)
            } catch {
                let error = ErrorResponse(code: -1, message: error.localizedDescription)
                return .failure(error)
            }
    }
    
    public func upload(url: String, imageName: String, imageJPEGData: Data, interceptor: NetworkRequestInterceptor? = nil) async throws -> Empty {
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            throw NSError()
        }
        return try await AF.upload(
            multipartFormData: { multipart in
                multipart.append(imageJPEGData, withName: "photo", fileName: "\(imageName).jpg", mimeType: "image/jpeg")
                if let value = "\(imageName).jpg".data(using: .utf8, allowLossyConversion: false) {
                    multipart.append(value, withName: "imageFile")
                }
            },
            to: baseURL + url,
            method: .post,
            headers: ["Content-Type" : "multipart/form-data"],
            interceptor: interceptor
        )
        .uploadProgress { progress in
            #if DEBUG
                print(progress)
            #endif
        }
        .serializingDecodable(Empty.self, emptyResponseCodes: [200])
        .value
    }

    private init() {}
}
