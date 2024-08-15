//
//  UpdateProfileView.swift
//  FeatureSetting
//
//  Created by 김용재 on 8/15/24.
//
import SwiftUI

import SharedDesignSystem
import SharedDesignSystemInterface
import DomainUserInterface

import ComposableArchitecture

public struct UpdateProfileView: View {
    
    @Bindable public var store: StoreOf<UpdateProfileFeature>
    @State private var keyboardHeight: CGFloat = 0
    
    public init(store: StoreOf<UpdateProfileFeature>) {
        self.store = store
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 48)
                    
                    Text("프로필 수정")
                        .font(.pretendard(kind: .heading_sm, type: .bold))
                        .foregroundColor(.mmGray1)
                    
                    Spacer()
                    
                    Image(uiImage: store.selectedPiece.roundImage.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.26)
                        .padding(.bottom, 18)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            Spacer().frame(width: 16)
                            ForEach(Character.allCases, id: \.self) { piece in
                                VStack {
                                    Image(uiImage: piece.basicImage.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.26, height: geometry.size.height * 0.11)
                                        .opacity(piece == store.selectedPiece ? 1.0 : 0.3)
                                        .onTapGesture {
                                            store.send(.pieceImageTapped(piece))
                                        }
                                    Text(piece.koreanName)
                                        .font(.pretendard(kind: .body_md, type:.bold))
                                        .frame(width: geometry.size.width * 0.26, height: 24)
                                        .foregroundColor(.mmGray2)
                                        .background(Color.mmGray5)
                                        .opacity(piece == store.selectedPiece ? 1.0 : 0.3)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.bottom, 38)
                    }
                    
                    MMTextField(
                        text: $store.nickName,
                        isValidInputText: $store.isValidNickName,
                        noticeMessage: $store.noticeMessage,
                        placeholder: "닉네임 입력"
                    )
                    .padding(.horizontal, 24)
                    
                    
                    Spacer()
                    
                    Spacer()
                    
                    MMRoundedButton(isEnabled: $store.isAllCompleted, title: "저장하기") {
                        store.send(.saveButtonTapped)
                    }
                    .frame(height: 60)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 36)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .offset(y: -keyboardHeight)
            }
            
            MMNavigationBar {
                store.send(.backButtonTapped)
            }
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .makeTapToHideKeyboard()
        .animation(.default, value: keyboardHeight)
        .onAppear(perform: addKeyboardObserver)
        .onDisappear(perform: removeKeyboardObserver)
    }
}

extension UpdateProfileView {
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
            keyboardHeight = keyboardFrame.height
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            keyboardHeight = 0
        }
    }
    
    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
