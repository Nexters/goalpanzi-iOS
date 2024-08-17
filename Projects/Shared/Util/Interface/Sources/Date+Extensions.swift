//
//  Date+Extensions.swift
//  SharedUtilInterface
//
//  Created by Haeseok Lee on 8/15/24.
//

import Foundation

public extension Date {
    
    var isAM: Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        return hour < 12
    }
}
