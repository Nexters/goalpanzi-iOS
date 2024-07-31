//
//  MissionMateTextField.swift
//  FeaturePieceCreationInterface
//
//  Created by Miro on 7/31/24.
//

import SwiftUI

struct MissionMateTextField: View {
    @Binding var text: String

    let placeholder: String
    var noticeMessage: String? = nil
    var isCompleted: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter text", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()
                .background(text.isEmpty ? Color.clear : Color.red.opacity(0.3))
                .animation(.default, value: text)
            if let noticeMessage {
                Text(noticeMessage)
                    .foregroundColor(text.isEmpty ? Color.primary : Color.red)
                    .padding(.horizontal)
                    .padding(.top, -10) // Adjust the padding to place the text closer to the TextField
            }
        }
        .padding()
    }
}
