//
//  DateFormatter+.swift
//  SharedUtil
//
//  Created by 김용재 on 7/26/24.
//

import Foundation

enum DateFormat: String {
    case yearMonthDate = "yyyy.MM.dd"
    case monthDate = "MM.dd"
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
    func formattedString(dateFormat: DateFormat) -> String {
        // ✅ 딕셔너리로 캐싱된 DateFormatter 를 재사용
        return dateFormat.formatter.string(from: self)
    }
}
