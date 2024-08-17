//
//  SettingVIew.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/14/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct SettingView: View {
    
    @Bindable var store: StoreOf<SettingFeature>
    
    public init(store: StoreOf<SettingFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                MMNavigationBar(
                    title: "설정"
                ) {
                    print("BackButtonTapped")
                }
                .padding(.bottom, 22)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        SettingSectionView(title: "내정보") {
                            SettingSectionRow(
                                title: "프로필 수정하기",
                                item: AnyView(AnyView(Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.mmDisabled))
                                )) {
                                    store.send(.navigateUpdateProfileViewTapped)
                                }
                        }
                        
                        SettingSectionView(title: "버전정보") {
                            SettingSectionRow(
                                title: "현재버전",
                                item: AnyView(Text("1.0.0")
                                    .font(.pretendard(kind: .body_xl, type: .light))
                                    .foregroundStyle(Color.mmGray1))
                            )
                        }
                        
                        SettingSectionView(title: "고객지원") {
                            SettingSectionRow(
                                title: "문의하기",
                                item: AnyView(Text(verbatim: "missionmateteam@gmail.com")
                                    .font(.pretendard(kind: .body_xl, type: .light))
                                    .foregroundStyle(Color.mmGray1)
                                )
                            )
                        }
                        
                        SettingSectionView(title: "약관 및 정책") {
                            SettingSectionRow(
                                title: "서비스 이용약관",
                                item: AnyView((AnyView(Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.mmDisabled))
                                )), action: {
                                    store.send(.navigateTermsOfUseViewTapped)
                                }
                            )
                            .padding(.bottom, 20)
                            
                            SettingSectionRow(
                                title: "개인정보 취급 방침",
                                item: AnyView((AnyView(Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.mmDisabled))
                                )), action: {
                                    store.send(.navigatePrivacyPolicyViewTapped)
                                }
                            )
                        }
                        
                        SettingSectionView(title: "로그인 정보") {
                            SettingSectionRow(
                                title: "로그아웃",
                                item: AnyView((AnyView(Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.mmDisabled))
                                )), action: {
                                    store.send(.navigateLogoutViewTapped)
                                }
                            )
                            .padding(.bottom, 20)
                            
                            SettingSectionRow(
                                title: "계정탈퇴",
                                item: AnyView((AnyView(Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.mmDisabled))
                                )), action: {
                                    store.send(.navigateProfileDeletionViewTapped)
                                }
                            )
                        }
                    }
                    
                }
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .padding(.horizontal, 24)
            .navigationDestination(
                item: $store.scope(state: \.destination?.updateProfile, action: \.destination.updateProfile)
            ) { store in
                UpdateProfileView(store: store)
            }
            .navigationDestination(
                item: $store.scope(state: \.destination?.privacyPolicy, action: \.destination.privacyPolicy)
            ) { store in
                InformationView(type: .privacyPolicy)
            }
            .navigationDestination(
                item: $store.scope(state: \.destination?.termsOfUse, action: \.destination.termsOfUse)
            ) { store in
                InformationView(type: .termsOfUse)
            }
            .fullScreenCover(
                item: $store.scope(state: \.destination?.logout, action: \.destination.logout)
            ) { store in
                LogoutConfirmView(store: store)
                    .presentationBackground(.clear)
            }
            .fullScreenCover(
                item: $store.scope(state: \.destination?.profileDeletion, action: \.destination.profileDeletion)
            ) { store in
                ProfileDeletionView(store: store)
                    .presentationBackground(.clear)
            }
        }
    }
}

struct SettingSectionView<Content: View>: View {
    
    private let title: String
    private let content: Content
    
    public init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.pretendard(kind: .body_lg, type: .light))
                .foregroundStyle(Color.mmGray3)
                .padding(.bottom, 20)
                .padding(.top, 18)
            
            content
                .padding(.bottom, 16)
            
            Divider()
        }
        .padding(.bottom, 10)
        
    }
}


public struct SettingSectionRow: View {
    private var title: String
    private var item: AnyView
    private var action: (() -> Void)?
    
    public init(title: String, item: AnyView, action: (() -> Void)? = nil) {
        self.title = title
        self.item = item
        self.action = action
    }
    
    public var body: some View {
        Group {
            if let action = action {
                Button(action: action) {
                    rowContent
                }
            } else {
                rowContent
            }
        }
    }
    
    private var rowContent: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.pretendard(kind: .body_xl, type: .light))
                .foregroundStyle(Color.mmGray1)
            
            Spacer()
            
            item
        }
    }
}
