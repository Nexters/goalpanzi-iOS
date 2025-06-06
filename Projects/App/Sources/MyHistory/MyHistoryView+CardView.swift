//
//  MyHistoryView+CardView.swift
//  MissionMate
//
//  Created by Haeseok Lee on 6/1/25.
//

import SwiftUI
import Kingfisher
import SharedUtil
import SharedDesignSystem
import SharedUtilInterface
import DomainUserInterface
import DomainHistoryInterface

extension MyHistoryView {
    
    struct CardView: View {
        
        let history: MissionHistoryInfo.History
        let size: CGSize
        private var shouldShowImageView: Bool { !history.randomImageUrlList.isEmpty }
        @State private var currentIndex = 0
        
        @ViewBuilder
        var body: some View {
            ZStack(alignment: .bottom) {
                if shouldShowImageView, let imageURL = history.randomImageUrlList[safe: currentIndex] {
                    ImageView(
                        size: size,
                        imageURL: imageURL,
                        imageURLsTotalCount: history.randomImageUrlList.count,
                        currentIndex: $currentIndex
                    )
                } else {
                    EmptyImageView(size: size)
                }
                InfoView(
                    size: size,
                    characters: history.characters,
                    description: history.description,
                    totalRankDescription: history.totalRankDescription,
                    rankDescription: history.rankDescription,
                    rankImage: history.rankImage,
                    dateString: history.dateString
                )
            }
            .frame(width: size.width, height: size.contentHeight)
        }
    }
}

extension MyHistoryView.CardView {
    
    struct ImageView: View {
        
        let size: CGSize
        let imageURL: URL
        let imageURLsTotalCount: Int
        @Binding var currentIndex: Int
        
        @ViewBuilder
        var body: some View {
            TimelineView(.periodic(from: .now, by: 3.0)) { context in
                KFImage(imageURL)
                    .resizable()
                    .placeholder({ Color.white })
                    .scaledToFill()
                    .frame(width: size.width, height: size.contentHeight)
                    .clipped()
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        )
                    )
                    .id(currentIndex)
                    .animation(.easeInOut(duration: 0.3), value: currentIndex)
                    .onChange(of: Int(context.date.timeIntervalSinceReferenceDate) % imageURLsTotalCount) { old, new in
                        currentIndex = new
                    }
            }
        }
    }
    
    struct EmptyImageView: View {
        
        let size: CGSize
        
        @ViewBuilder
        var body: some View {
            VStack {
                ZStack {
                    Image(uiImage: SharedDesignSystemAsset.Images.noCertificationBackground.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 172, height: 290)
                }
                .frame(width: size.width, height: size.contentHeight - 152)
                .background(Color.mmGray4)
                .padding(.bottom, 152)
            }
            .frame(width: size.width, height: size.contentHeight)
            .background(Color.mmWhite)
        }
    }
    
    struct InfoView: View {
        
        let size: CGSize
        let characters: [DomainUserInterface.Character]
        let description: String
        let totalRankDescription: String
        let rankDescription: String
        let rankImage: Image
        let dateString: String
        
        var body: some View {
            VStack() {
                VStack(spacing: 8) {
                    HStack(alignment: .bottom, spacing: 12) {
                        VStack(alignment: .leading, spacing: 2) {
                            MyHistoryView.CharacterGroupView(characters: characters)
                                .frame(height: 32)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 2)
                            Text(description)
                                .foregroundStyle(Color.mmGray1)
                                .font(.pretendard(kind: .title_lg, type: .bold))
                                .frame(maxHeight: .infinity, alignment: .leading)
                            HStack(spacing: 10) {
                                Text(totalRankDescription)
                                    .foregroundStyle(Color.mmOrange)
                                    .font(.pretendard(kind: .body_lg, type: .bold))
                                Text(rankDescription)
                                    .foregroundStyle(Color.mmGray1)
                                    .font(.pretendard(kind: .body_lg, type: .regular))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        rankImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 63, height: 59)
                    }
                    Text(dateString)
                        .foregroundStyle(Color.mmGray3)
                        .font(.pretendard(kind: .body_md, type: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .frame(width: size.width, height: 152)
            .background(.ultraThinMaterial, in: Rectangle())
        }
    }
}

private extension CGSize {
    
    var contentHeight: CGFloat { height * 0.9 }
}
