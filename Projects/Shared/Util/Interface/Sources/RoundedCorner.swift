//
//  RoundedCorner.swift
//  SharedUtilInterface
//
//  Created by Haeseok Lee on 8/4/24.
//

import SwiftUI

public struct RoundedCorner: Shape {
    
    public let radius: CGFloat
    
    public let corners: UIRectCorner

    public init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
