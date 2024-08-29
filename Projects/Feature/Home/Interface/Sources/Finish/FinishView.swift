//
//  FinishView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/13/24.
//

import SwiftUI
import SharedUtil
import DomainPlayerInterface
import SharedDesignSystem
import ComposableArchitecture

public struct FinishView: View {
    
    private let store: StoreOf<FinishFeature>
    
    public init(store: StoreOf<FinishFeature>) {
        self.store = store
    }
    
    public var body: some View {
        GeometryReader { reader in
            VStack {
                ZStack(alignment: .top) {
                    HStack(alignment: .center) {
                        Spacer()
                        Button(action: {
                            store.send(.didTapSettingButton)
                        }) {
                            SharedDesignSystemAsset.Images.settingFill.swiftUIImage
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
                        }
                    }
                    .padding(.horizontal, 24)
                    .frame(height: 45)
                    .zIndex(999)
                    
                    ScrollView {
                        ZStack(alignment: .bottom) {
                            SharedDesignSystemAsset.Images.jejuBackground2.swiftUIImage
                                .resizable()
                                .ignoresSafeArea(.all)
                                .frame(height: reader.size.height * 0.6)
                            
                            SharedDesignSystemAsset.Images.goal.swiftUIImage
                                .resizable()
                                .frame(width: reader.size.width, height: 282)
                            
                            store.player.character.basicImage.swiftUIImage
                                .resizable()
                                .frame(width: 212, height: 212)
                                .offset(y: -37)
                        }
                        VStack(alignment: .center, spacing: 0) {
                            Text("\(store.rank)등")
                                .font(.pretendard(kind: .heading_xl, type: .bold))
                                .multilineTextAlignment(.center)
                            Text("경쟁이 종료되었어요.")
                                .font(.pretendard(kind: .title_xl, type: .bold))
                                .multilineTextAlignment(.center)
                                .padding(.top, 20)
                            Text("보드판은 삭제되며\n초기화면으로 돌아가요!")
                                .font(.pretendard(kind: .body_xl, type: .light))
                                .multilineTextAlignment(.center)
                                .padding(.top, 4)
                        }
                        .backgroundStyle(.white)
                    }
                    .ignoresSafeArea(.all)
                    
                    
                }
                
                
                Button(action: {
                    store.send(.didTapConfirmButton)
                }) {
                    Text("확인")
                        .font(.pretendard(kind: .body_lg, type: .bold))
                        .foregroundColor(SharedDesignSystemAsset.Colors.white.swiftUIColor)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
