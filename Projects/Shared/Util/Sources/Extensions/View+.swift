//
//  View+.swift
//  SharedUtil
//
//  Created by 김용재 on 8/12/24.
//

import SwiftUI

extension View {
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    public func makeTapToHideKeyboard() -> some View {
        self
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
    }
}
