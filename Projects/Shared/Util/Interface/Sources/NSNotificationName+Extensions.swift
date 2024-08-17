//
//  NSNotificationName+Extensions.swift
//  SharedUtilInterface
//
//  Created by Haeseok Lee on 8/17/24.
//

import Foundation

public extension NSNotification.Name {
    
    static let didFailTokenRefreshing: Self = Notification.Name(rawValue: "didFailTokenRefreshing")
}
