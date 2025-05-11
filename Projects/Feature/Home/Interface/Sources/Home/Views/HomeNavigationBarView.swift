//
//  HomeNavigationBarView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/15/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

struct HomeNavigationBarView: View {
    
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                Button(action: {
                    store.send(.didTapMissionInfoButton)
                }) {
                    SharedDesignSystemAsset.Images.flagFill.swiftUIImage
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
                }
                .overlay {
                    SharedDesignSystemAsset.Images.missionInfoGuideToolTip.swiftUIImage
                        .resizable()
                        .frame(width: 161, height: 72)
                        .offset(x: 50, y: 50)
                        .onTapGesture {
                            store.send(.didTapMissionInfoGuideToolTip)
                        }
                        .isHidden(store.isMissionInfoGuideToolTipShowed, remove: true)
                }
                
                Spacer()
                
                Button(action: {
                    store.send(.didTapInvitationInfoButton)
                }) {
                    SharedDesignSystemAsset.Images.userAddFill.swiftUIImage
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
                }
                .isHidden(!((store.competition?.status.isCreated) ?? false), remove: true)
                .overlay {
                    SharedDesignSystemAsset.Images.invitationCodeGuideToolTip.swiftUIImage
                        .resizable()
                        .frame(width: 161, height: 72)
                        .offset(x: -42, y: 50)
                        .onTapGesture {
                            store.send(.didTapInvitationInfoToolTip)
                        }
                        .isHidden(
                            store.isInvitationGuideToolTipShowed || !((store.competition?.status.isCreated) ?? false),
                            remove: true
                        )
                }
                
            }
            
            Text(store.mission?.description ?? "")
                .font(.pretendard(kind: .title_lg, type: .bold))
                .foregroundColor(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
        }
        .padding(.horizontal, 24)
        .frame(height: 45)
        .zIndex(999)
    }
}
