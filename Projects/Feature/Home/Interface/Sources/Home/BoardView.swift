//
//  BoardView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/7/24.
//

import SwiftUI
import SharedUtil
import SharedDesignSystem
import ComposableArchitecture
import DomainBoardInterface
import DomainPlayerInterface

struct BoardView: View {
    
    let reader: GeometryProxy
    let scrollProxy: ScrollViewProxy
    
    @Bindable var store: StoreOf<HomeFeature>
    @State var shouldShowMovingPiece: Bool = false
    @State var movingDirection: DomainBoardInterface.Direction? = nil
    
    var body: some View {
        let numberOfRows: Int = store.competition.board.numberOfRows
        let numberOfColumns: Int = store.competition.board.numberOfColumns
        let myPiece: Piece? = store.competition.myPiece
//        if store.shouldStartAnimation {
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
//                self.shouldShowRepresentativePiece = false
//                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
//                    self.shouldShowMovingPiece = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
//                        guard let myPiece else { return }
//                        self.movingDirection = store.competition.board.move(piece: myPiece, to: myPiece.position + 1)
//                    }
//                }
//            }
//        }
        
        return Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<numberOfRows, id: \.self) { row in
                GridRow {
                    let indices = Array((0..<numberOfColumns))
                    ForEach((row % 2 == 0) ? indices : indices.reversed(), id: \.self) { col in
                        let index = col + (row * numberOfColumns)
                        let position = Position(index: index)
                        BlockView(
                            block: store.competition.board.findBlock(by: position), 
                            event: store.competition.board.findEvent(by: position),
                            representativePiece: store.competition.board.representativePiece(by: position),
                            movingPiece: myPiece?.position == position ? myPiece : nil,
                            myPiece: myPiece,
                            numberOfSamePositionPieces: store.competition.board.samePositionPieces(by: position).count,
                            shouldShowMovingPiece: $shouldShowMovingPiece,
                            movingDirection: $movingDirection
                        )
                        .zIndex(-Double(index))
                        .id(index)
                    }
                }
            }
            .onAppear {
                guard let myPiece else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)) {
                        scrollProxy.scrollTo(myPiece.position.index, anchor: .center)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                        self.shouldShowMovingPiece = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            self.movingDirection = store.competition.board.move(piece: myPiece, to: myPiece.position + 1)
                        }
                    }
                }
                
            }
        }
        .padding(.top, 4)
    }
}

