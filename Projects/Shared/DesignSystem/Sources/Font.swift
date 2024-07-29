//
//  Font.swift
//  SharedDesignSystem
//
//  Created by Haeseok Lee on 7/29/24.
//

import ComposableArchitecture
import SwiftUI

public extension Font {
    
    static func pretendard(size fontSize: CGFloat, type: FontType) -> Font {
        return .custom("\(type.name)", size: fontSize)
    }
    
    static func pretendard(kind fontKind: FontKind, type: FontType) -> Font {
        return fontKind.font(type: type)
    }
}

public extension Font {
    
    enum FontKind {
        case heading_xl
        case heading_lg
        case heading_md
        case heading_sm
        case title_xl
        case title_lg
        case body_xl
        case body_lg
        case body_md
        case body_sm
    }
    
    enum FontType {
        case black
        case bold
        case extraBold
        case extraLight
        case light
        case medium
        case regular
        case semiBold
        case thin
        
        var name : String {
            switch self {
            case .black:
                return "Pretendard-Black"
            case .bold:
                return "Pretendard-Bold"
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .extraLight:
                return "Pretendard-ExtraLight"
            case .light:
                return "Pretendard-Light"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .semiBold:
                return "Pretendard-SemiBold"
            case .thin:
                return "Pretendard-Thin"
            }
        }
    }
}


public extension Font.FontKind {
    
    func font(type: Font.FontType) -> Font {
        switch self {
        case .heading_xl:
            return .pretendard(size: 60, type: type)
        case .heading_lg:
            return .pretendard(size: 48, type: type)
        case .heading_md:
            return .pretendard(size: 34, type: type)
        case .heading_sm:
            return .pretendard(size: 30, type: type)
        case .title_xl:
            return .pretendard(size: 24, type: type)
        case .title_lg:
            return .pretendard(size: 20, type: type)
        case .body_xl:
            return .pretendard(size: 18, type: type)
        case .body_lg:
            return .pretendard(size: 16, type: type)
        case .body_md:
            return .pretendard(size: 14, type: type)
        case .body_sm:
            return .pretendard(size: 12, type: type)
        }
    }
}
