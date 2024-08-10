//
//  Mission.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

public struct Mission: CustomStringConvertible {
    
    public let description: String
    
    public let startDate: Date
    
    public let endDate: Date
    
    public init(description: String, startDate: Date, endDate: Date) {
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}
