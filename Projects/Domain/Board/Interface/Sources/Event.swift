//
//  Event.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 8/1/24.
//

import Foundation

public enum Event {
    case item(ItemInfo)
}

public extension Event {
    
    struct ItemInfo: CustomStringConvertible {
        public let image: String
        public let description: String
        
        init(image: String, description: String) {
            self.image = image
            self.description = description
        }
    }
}
