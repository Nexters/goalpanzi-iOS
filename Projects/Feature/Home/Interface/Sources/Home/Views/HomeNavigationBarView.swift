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
                        .isHidden(
                            store.isMissionInfoGuideToolTipShowed || store.competition?.state != .notStarted(hasOtherPlayer: true),
                            remove: true
                        )
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: {
                        store.send(.didTapInvitationInfoButton)
                    }) {
                        SharedDesignSystemAsset.Images.userAddFill.swiftUIImage
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
                    }
                    .isHidden(store.competition?.board.isDisabled == false)
                    .overlay {
                        SharedDesignSystemAsset.Images.invitationCodeGuideToolTip.swiftUIImage
                            .resizable()
                            .frame(width: 161, height: 72)
                            .offset(x: -42, y: 50)
                            
                            .onTapGesture {
                                store.send(.didTapInvitationInfoToolTip)
                            }
                            .isHidden(
                                store.isInvitationGuideToolTipShowed || store.competition?.state != .notStarted(hasOtherPlayer: false),
                                remove: true
                            )
                    }
                    
                    Button(action: {
                        store.send(.didTapSettingButton)
                    }) {
                        SharedDesignSystemAsset.Images.settingFill.swiftUIImage
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
                    }
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
