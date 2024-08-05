//
//  MMPopupView.swift
//  SharedThirdPartyLibInterface
//
//  Created by Haeseok Lee on 8/5/24.
//

import SwiftUI

// TODO: Fix 애니메이션이 동작하지 않는 문제

//public struct MMPopupStyle: ViewModifier {
//    
//    @State private var scale = 0.5
//    
//    public func body(content: Content) -> some View {
//        ZStack {
//            Color.black.opacity(0.4)
//                .edgesIgnoringSafeArea(.all)
//                .transition(.opacity)
//            content
//                .animate(using: .spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)) {
//                    scale = 1.0
//                }
//        }
//    }
//}
//
//public extension View {
//    
//    func popup() -> some View {
//        modifier(MMPopupStyle())
//    }
//}
//
//
//public struct MMPopupView: View {
//    
//    let contentView: any View
//    @State private var scale = 0.5
//    
//    public init(contentView: any View, scale: Double = 0.5) {
//        self.contentView = contentView
//        self.scale = scale
//    }
//    
//    public var body: some View {
//        ZStack {
//            Color.black.opacity(0.4)
//                .edgesIgnoringSafeArea(.all)
//                .transition(.opacity)
//            AnyView(contentView)
//                .animate(using: .spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)) {
//                    scale = 1.0
//                }
//        }
//    }
//}
