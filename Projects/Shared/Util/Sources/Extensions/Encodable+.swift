//
//  Encodable+.swift
//  SharedUtil
//
//  Created by Haeseok Lee on 7/18/24.
//

import Foundation
import SharedUtilInterface

extension Encodable  {
    
    public func toDictionary() throws -> [String : Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        return jsonObject as? [String : Any]
    }
}
