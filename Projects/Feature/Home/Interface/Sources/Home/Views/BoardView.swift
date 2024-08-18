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
    
    let proxy: GeometryProxy
    let scrollProxy: ScrollViewProxy
    
    @Bindable var store: StoreOf<HomeFeature>
    @State var shouldShowMovingPiece: Bool = false
    @State var movingDirection: DomainBoardInterface.Direction? = nil
    
    var body: some View {
        let numberOfRows: Int = store.competition?.board.numberOfRows ?? 0
        let numberOfColumns: Int = store.competition?.board.numberOfColumns ?? 0
        
        return Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<numberOfRows, id: \.self) { row in
                GridRow {
                    let indices = Array((0..<numberOfColumns))
                    ForEach((row % 2 == 0) ? indices : indices.reversed(), id: \.self) { col in
                        let index = col + (row * numberOfColumns)
                        let position = Position(index: index)
                        BlockView(
                            store: store,
                            block: store.competition?.board.findBlock(by: position),
                            event: store.competition?.board.findEvent(by: position),
                            representativePiece: store.competition?.representativePiece(by: position),
                            numberOfSamePositionPieces: store.competition?.board.findPieces(by: position).count ?? 0,
                            movingPiece: store.movingPiece?.position == position ? store.movingPiece : nil,
                            shouldShowMovingPiece: $shouldShowMovingPiece,
                            movingDirection: $movingDirection
                        )
                        .zIndex(-Double(index))
                        .id(index)
                    }
                }
            }
        }
        .padding(.top, 4)
        .onChange(of: store.movingPiece) { oldValue, newValue in
            guard let movingPiece = newValue else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                withAnimation(.spring(duration: 0.5), {
                    scrollProxy.scrollTo(movingPiece.position.index, anchor: .center)
                }, completion: {
                    withAnimation(.easeInOut(duration: 0.5), {
                        self.shouldShowMovingPiece = true
                    }, completion: {
                        withAnimation(.easeInOut(duration: 0.5), {
                            self.movingDirection = store.competition?.board.move(piece: movingPiece, to: movingPiece.position + 1)
                        }, completion: {
                            self.store.send(.didFinishMoving(piece: store.movingPiece))
                        })
                    })
                })
            }
        }
    }
}

