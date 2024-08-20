//
//  NetworkProvider.swift
//  CoreNetworkInterface
//
//  Created by Haeseok Lee on 7/19/24.
//

import Foundation
import Alamofire
import SharedUtilInterface

public struct ErrorResponse: Error, Decodable {
    let code: Int
    public let message: String
}

public struct NetworkProvider: NetworkProviderType {
    
    public static let shared: NetworkProviderType = NetworkProvider()

    public func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N, decoder: JSONDecoder = .jsonDecoder, interceptor: NetworkRequestInterceptor? = nil) async -> Result<T, ErrorResponse> where N.Response == T {
        do {
                let urlRequest: URLRequest = try endpoint.makeURLRequest()

                let dataTask = AF.request(urlRequest, interceptor: interceptor)
                    .validate()
                    .serializingDecodable(T.self, decoder: decoder, emptyResponseCodes: Set(200...299))

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
    
    public func upload(url: String, imageJPEGData: Data, interceptor: NetworkRequestInterceptor? = nil) async throws -> String {
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            throw NSError()
        }
        return try await AF.upload(
            multipartFormData: { multipart in
                multipart.append(imageJPEGData, withName: "imageFile", fileName: "imageFile.jpg", mimeType: "image/*")
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
        .serializingResponse(using: .string)
        .value
    }

    private init() {}
}
