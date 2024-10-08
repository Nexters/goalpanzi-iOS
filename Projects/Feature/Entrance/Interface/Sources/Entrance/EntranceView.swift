//
//  EntranceView.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/5/24.
//

import SwiftUI

import FeatureSettingInterface
import DomainUserInterface
import SharedDesignSystem

import ComposableArchitecture

public struct EntranceView: View {
    
    @Bindable public var store: StoreOf<EntranceFeature>
    
    public init(store: StoreOf<EntranceFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ZStack {
                Image(uiImage: SharedDesignSystemAsset.Images.jejuIslandMaskBackground.image)
                    .resizable()
                    .edgesIgnoringSafeArea(.top)
                
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            store.send(.didTapSettingButton)
                        }) {
                            Image(uiImage: SharedDesignSystemAsset.Images.setting.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 21, height: 21)
                        }
                        .padding(.trailing, 20)
                    }
                    .padding(.top, 7)
                    .padding(.bottom, 13)
                    
                    Text("미션 완수를 위해\n경쟁할 준비가 되었나요?")
                        .foregroundStyle(Color.mmGray1)
                        .font(.pretendard(kind: .heading_sm, type: .bold))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    MMCapsuleTagView(
                        text: "LV1. 제주도",
                        font: .pretendard(kind: .title_lg, type: .medium),
                        horizontalPadding: 16,
                        verticalPadding: 4
                    )
                    
                    Spacer()
                    
                    ZStack {
                        Image(uiImage: SharedDesignSystemAsset.Images.emptyJejuIslandBackground.image)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 228)
                        if store.isCheckingProfile {
                            ProgressView()
                        } else {
                            Image(uiImage: store.userProfileCharacter.shadowImage.image)
                                .resizable()
                                .frame(width: 212, height: 212)
                                .offset(y: 20)
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        entranceSelectionButton(
                            title: "미션보드\n생성하기",
                            description: "내 목표는 내가~",
                            iconImage: SharedDesignSystemAsset.Images.coloredPencil.image
                        ) {
                            store.send(.createMissionButtonTapped)
                        }
                        
                        Spacer()
                            .frame(maxWidth: 23)

                        entranceSelectionButton(
                            title: "초대코드\n입력하기",
                            description: "초대받고 왔지~",
                            iconImage: SharedDesignSystemAsset.Images.coloredAddPerson.image
                        ) {
                            store.send(.enterInvitationCodeButtonTapped)
                        }
                    }
                    .padding(.horizontal, 24)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.horizontal)
        } destination: { store in
            switch store.case {
            case let .missionContentSetting(store):
                MissionContentSettingView(store: store)
            case let .missionAuthTimeSetting(store):
                MissionAuthTimeSettingView(store: store)
            case let .missionDurationSetting(store):
                MissionDurationSettingView(store: store)
            case let .missionInputInviationCode(store):
                MissionInvitationCodeView(store: store)
            case let .setting(store):
                SettingView(store: store)
            }
        }
        .overlay {
            if let store = store.scope(state: \.pieceCreationCompleted, action: \.pieceCreationCompleted.presented) {
                PieceCreationCompletedView(store: store)
            }
        }
        .task {
            await store
                .send(.onAppear)
                .finish()
        }
    }
    
    private func entranceSelectionButton(
        title: String,
        description: String,
        iconImage: UIImage,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.mmBlack.opacity(0.2), lineWidth: 1)
                .frame(height: 188)
                .overlay(
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(.pretendard(kind: .title_xl, type: .bold))
                                .foregroundStyle(Color.mmGray1)
                                .multilineTextAlignment(.leading)
                            Text(description)
                                .font(.pretendard(kind: .body_lg, type: .medium))
                                .foregroundStyle(Color.mmGray3)
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            Image(uiImage: iconImage)
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                .padding(20)
                )
        }
    }
}
