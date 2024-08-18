//
//  MissionInfoView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/8/24.
//
import SwiftUI
import SharedUtil
import SharedDesignSystem
import ComposableArchitecture

public struct MissionInfoView: View {
    
    private let store: StoreOf<MissionInfoFeature>
    
    public init(store: StoreOf<MissionInfoFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack(spacing: 29) {
                    VStack(spacing: 12) {
                        Text("경쟁 내용")
                            .font(.pretendard(kind: .title_xl, type: .bold))
                            .foregroundColor(SharedDesignSystemAsset.Colors.black.swiftUIColor)
                        Group {
                            Text("*기간 대비 인증요일을 계산해\n")
                                .font(.pretendard(kind: .body_xl, type: .regular))
                                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                            +
                            Text("인증횟수(보드판 수)는 총 \(store.totalBlockCount)개 ")
                                .font(.pretendard(kind: .body_xl, type: .regular))
                                .foregroundColor(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                            +
                            Text("가 \n생성되었어요")
                                .font(.pretendard(kind: .body_xl, type: .regular))
                                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                        }
                        .multilineTextAlignment(.center)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(Array(store.infos.enumerated()), id: \.offset) { index, info in
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(alignment: .bottom) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(info.key)
                                            .font(.pretendard(kind: .body_md, type: .regular))
                                            .foregroundStyle(SharedDesignSystemAsset.Colors.gray3.swiftUIColor)
                                        Text(info.value)
                                            .font(.pretendard(kind: .body_lg, type: .bold))
                                            .foregroundStyle(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                                    }
                                    Spacer()
                                    if index == .zero {
                                        Button(action: {
                                            store.send(.didTapDeleteButton)
                                        }, label: {
                                            Text("삭제하기")
                                                .font(.pretendard(kind: .body_lg, type: .light))
                                                .foregroundStyle(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                                        })
                                    }
                                }
                                
                                VStack(spacing: 0) {
                                    Spacer()
                                    Divider()
                                        .frame(height: 1)
                                        .background(SharedDesignSystemAsset.Colors.gray4.swiftUIColor)
                                    Spacer()
                                }
                                .frame(height: 32)
                                .isHidden(store.infos.count - 1 == index, remove: true)
                            }
                            
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .overlay {
            if let store = store.scope(state: \.destination?.missionDelete, action: \.destination.missionDelete) {
                MissionDeleteView(store: store)
            }
        }
    }
    
    var backButton: some View {
        Button {
            store.send(.didTapBackButton)
        } label: {
            SharedDesignSystemAsset.Images.arrow.swiftUIImage
                .resizable()
                .frame(width: 28, height: 28)
        }
    }
}

