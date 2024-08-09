//
//  BlockView.swift
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

struct BlockView: View {
    
    let block: Block?
    
    let event: DomainBoardInterface.Event?
    
    let representativePiece: Piece?
    
    let movingPiece: Piece?
    
    let myPiece: Piece?
    
    let numberOfSamePositionPieces: Int
    
    @Binding var shouldShowMovingPiece: Bool
    @Binding var movingDirection: DomainBoardInterface.Direction?
    
    var body: some View {
        ZStack(alignment: .center) {
            if let block {
                if block.isStartBlock {
                    block.theme.startImageAsset.swiftUIImage
                        .resizable()
                        .opacity(block.isDisabled ? 0.5 : 1.0)
                        .aspectRatio(1.0, contentMode: .fit)
                    
                } else if block.isConquered, !block.isDisabled {
                    block.theme.conqueredImageAsset(kind: block.kind).swiftUIImage
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                    
                } else {
                    block.theme.normalImageAsset(kind: block.kind, isHighlighted: block.position.index % 2 == 0).swiftUIImage
                        .resizable()
                        .opacity(block.isDisabled ? 0.5 : 1.0)
                        .aspectRatio(1.0, contentMode: .fit)
                }
                
                if block.isStartBlock {
                    Text("START")
                        .font(.pretendard(kind: .title_lg, type: .bold))
                        .foregroundStyle(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                    
                } else if block.isLastBlock {
                    Text("GOAL")
                        .font(.pretendard(kind: .title_lg, type: .bold))
                        .foregroundStyle(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                }
                
                if let event {
                    if block.isConquered {
                        block.theme.eventImageAsset(kind: block.kind, event: event)?.swiftUIImage
                            .resizable()
                            .opacity(block.isDisabled ? 0.5 : 1.0)
                            .aspectRatio(1.0, contentMode: .fit)
                    } else {
                        SharedDesignSystemAsset.Images.gift.swiftUIImage
                            .resizable()
                            .padding(35)
                            .opacity(block.isDisabled ? 0.5 : 1.0)
                    }
                }
                
                if let representativePiece {
                    let isMe = representativePiece == myPiece
                    GeometryReader { reader in
                        ZStack(alignment: .topTrailing) {
                            VStack(spacing: 0) {
                                representativePiece.image.swiftUIImage
                                    .resizable()
                                    .aspectRatio(1.0, contentMode: .fit)
                                
                                Text("\(representativePiece.name)")
                                    .font(.pretendard(kind: .body_md, type: .bold))
                                    .lineLimit(1)
                                    .foregroundColor(
                                        isMe
                                        ? SharedDesignSystemAsset.Colors.white.swiftUIColor
                                        : SharedDesignSystemAsset.Colors.gray1.swiftUIColor
                                    )
                                    .frame(height: 21.7)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        isMe
                                        ? SharedDesignSystemAsset.Colors.orange.swiftUIColor
                                        : SharedDesignSystemAsset.Colors.white.swiftUIColor
                                    )
                                    .clipShape(Capsule())
                                    .offset(x: 0, y: -7)
                            }
                            .padding(.horizontal, 12)
                            .padding(.top, 2)
                            .padding(.bottom, 1)
                            
                            if numberOfSamePositionPieces > 1 {
                                HStack(alignment: .center, spacing: 3) {
                                    representativePiece.image.swiftUIImage
                                        .resizable()
                                        .frame(width: 22, height: 22)
                                        .zIndex(1)
                                    
                                    Text("\(numberOfSamePositionPieces)")
                                        .font(.pretendard(kind: .body_md, type: .bold))
                                        .lineLimit(1)
                                        .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                                        .zIndex(1)
                                }
                                .padding(.leading, 4)
                                .padding(.trailing, 8)
                                .padding(.vertical, 1)
                                .frame(height: 24)
                                .frame(minWidth: 48)
                                .background(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(SharedDesignSystemAsset.Colors.white.swiftUIColor, lineWidth: 0.5))
                                .offset(x: 0, y: 2)
                            }
                        }
                    }
                }
            }
            
            if let movingPiece {
                let isMe = movingPiece == myPiece
                GeometryReader { reader in
                    VStack(spacing: 0) {
                        if shouldShowMovingPiece {
                            movingPiece.image.swiftUIImage
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                            Text("\(movingPiece.name)")
                                .font(.pretendard(kind: .body_md, type: .bold))
                                .lineLimit(1)
                                .foregroundColor(
                                    isMe
                                    ? SharedDesignSystemAsset.Colors.white.swiftUIColor
                                    : SharedDesignSystemAsset.Colors.gray1.swiftUIColor
                                )
                                .frame(height: 21.7)
                                .frame(maxWidth: .infinity)
                                .background(
                                    isMe
                                    ? SharedDesignSystemAsset.Colors.orange.swiftUIColor
                                    : SharedDesignSystemAsset.Colors.white.swiftUIColor
                                )
                                .clipShape(Capsule())
                                .offset(x: 0, y: -7)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 2)
                    .padding(.bottom, 1)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1.0), value: shouldShowMovingPiece)
                    .opacity(shouldShowMovingPiece ? 1.0 : 0.0)
                    .transition(.slide)
                    .animation(.easeInOut(duration: 1.0), value: movingDirection != nil)
                    .position(calcNextPoint(reader: reader, movingDirection: movingDirection))
                }
            }
        }
        
    }
    
    func calcNextPoint(reader: GeometryProxy, movingDirection direction: DomainBoardInterface.Direction?) -> CGPoint {
        let frame = reader.frame(in: .local)
        let (width, originX, originY) = (frame.size.width, frame.midX, frame.midY)
        if direction == nil {
            return CGPoint(x: originX, y: originY)
        }
        switch direction {
        case .right:
            return CGPoint(x: originX + width, y: originY)
        case .left:
            return CGPoint(x: originX - width, y: originY)
        case .down:
            return CGPoint(x: originX, y: originY + width)
        default:
            return CGPoint(x: originX, y: originY)
        }
    }
}
