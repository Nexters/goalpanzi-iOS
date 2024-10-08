//
//  DateFormatter+.swift
//  SharedUtil
//
//  Created by 김용재 on 7/26/24.
//

import Foundation

public enum DateFormat: String {
    case compactYearMonthDateTime = "yyyyMMddHHmmss"
    case yearMonthDate = "yyyy.MM.dd"
    case longYearMonthDateTimeZone = "yyyy-MM-dd'T'HH:mm:ss"
}

extension DateFormat {
    var formatter: DateFormatter {
        guard let formatter = DateFormat.cachedFormatters[self] else {
            let generatedFormatter = DateFormat.makeFormatter(withDateFormat: self)
            DateFormat.cachedFormatters[self] = generatedFormatter
            return generatedFormatter
        }

        return formatter
    }
    
    private static var cachedFormatters: [DateFormat: DateFormatter] = [:]

    private static func makeFormatter(withDateFormat dateFormat: DateFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        formatter.locale = .current
        return formatter
    }
}

extension Date {
    public func formattedString(dateFormat: DateFormat) -> String {
        return dateFormat.formatter.string(from: self)
    }
}

extension String {
    public func toDate(format: DateFormat) -> Date? {
        return format.formatter.date(from: self)
    }
}

