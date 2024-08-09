//
//  MMTextFieldModifier.swift
//  SharedDesignSystem
//
//  Created by 김용재 on 8/10/24.
//

import SwiftUI

struct MMTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
    }
}

extension View {
    
    public func disableAutoFunctions() -> some View {
        modifier(MMTextFieldModifier())
    }
}
