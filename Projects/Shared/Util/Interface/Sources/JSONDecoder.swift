//
//  JSONDecoder.swift
//  SharedUtilInterface
//
//  Created by Haeseok Lee on 8/17/24.
//

import Foundation

public extension JSONDecoder {
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.serverTimeFormatter)
        return decoder
    }()
}
