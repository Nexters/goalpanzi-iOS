//
//  HistoryServiceable.swift
//  DomainHistory
//
//  Created by Haeseok Lee on 6/1/25.
//

import Foundation

public protocol HistoryServiceable {
    
    var getMissionsHistoriesMe: @Sendable (_ page: Int, _ pageSize: Int) async throws -> MissionHistoryInfo { get }
}
