//
//  DateFormatter+Extensions.swift
//  SharedUtilInterface
//
//  Created by Haeseok Lee on 8/14/24.
//

import Foundation

public extension DateFormatter {
    
    static let serverTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        return formatter
    }()
    
    static let yearMonthDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}
