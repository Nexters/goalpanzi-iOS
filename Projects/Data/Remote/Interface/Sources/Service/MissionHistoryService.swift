//
//  HistoryService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 6/1/25.
//

import Foundation
import DomainHistoryInterface


public struct MissionHistoryService: HistoryServiceable {
    
    public var getMissionsHistoriesMe: @Sendable (Int, Int) async throws -> MissionHistoryInfo
    
    public init(getMissionsHistoriesMe: @Sendable @escaping (Int, Int) async throws -> MissionHistoryInfo) {
        self.getMissionsHistoriesMe = getMissionsHistoriesMe
    }
}
