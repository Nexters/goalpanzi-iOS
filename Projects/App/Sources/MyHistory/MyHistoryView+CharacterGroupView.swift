//
//  MyHistoryView+CharacterGroupView.swift
//  MissionMate
//
//  Created by Haeseok Lee on 6/1/25.
//

import SwiftUI
import DomainUserInterface

extension MyHistoryView {
    
    struct CharacterGroupView: View {
        
        let characters: [DomainUserInterface.Character]
        var displayCharacters: [DomainUserInterface.Character] { Array(characters.prefix(3)) }
        var additionalTextCounter: String { "\(characters.count)명" }
        
        @ViewBuilder
        var body: some View {
            HStack(spacing: 4) {
                HStack(spacing: -10) {
                    ForEach(Array(displayCharacters.enumerated()), id: \.offset) { _, character in
                        character.shadowImage.swiftUIImage
                            .resizable()
                            .background(Color.mmWhite)
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .overlay(content: {
                                Circle()
                                    .stroke(Color.mmGray5, lineWidth: 1)
                            })
                    }
                }
                Text(additionalTextCounter)
                    .foregroundStyle(Color.mmGray1)
                    .font(.pretendard(kind: .body_xl, type: .bold))
            }
        }
    }
}

