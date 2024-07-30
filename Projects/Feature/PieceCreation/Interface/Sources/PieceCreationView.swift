//
//  PieceCreationView.swift
//  FeaturePieceCreationInterface
//
//  Created by 김용재 on 7/30/24.
//

import SwiftUI

import ComposableArchitecture
import SharedDesignSystem

public struct PieceCreationView: View {
    public let store: StoreOf<PieceCreationFeature>
    @State private var selectedPiece: Piece = .rabbit
    
    public init(store: StoreOf<PieceCreationFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            Image(uiImage: selectedPiece.roundImage)
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Spacer().frame(width: 16)
                    ForEach(Piece.allCases, id: \.self) { piece in
                        VStack {
                            Image(uiImage: piece == selectedPiece ? piece.roundImage : piece.dimmedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    selectedPiece = piece
                                }
                            Text(piece.koreanName)
                            
                        }
                        
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}
