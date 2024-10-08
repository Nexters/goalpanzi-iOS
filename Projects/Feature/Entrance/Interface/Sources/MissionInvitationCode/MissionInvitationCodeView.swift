//
//  MissionInvitationCodeView.swift
//  FeatureEntrance
//
//  Created by Miro on 8/8/24.
//

import SwiftUI

import SharedDesignSystem
import SharedUtil

import ComposableArchitecture
import Combine

public struct MissionInvitationCodeView: View {
    
    @Bindable public var store: StoreOf<MissionInvitationCodeFeature>
    
    @State private var showToastMessage = false
    
    public init(store: StoreOf<MissionInvitationCodeFeature>) {
        self.store = store
    }
    
    enum FocusTextField {
        case first
        case second
        case third
        case fourth
    }
    // TODO: State로 이동하기 -> TCA Tutorial 확인
    @FocusState private var textFieldFocusState: FocusTextField?
    @State private var keyboardHeight: CGFloat = 0
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 22)
                    
                    VStack(alignment: .leading) {
                        invitationCodeHeaderView
                            .padding(.bottom, 56)
                        
                        HStack {
                            // TODO: 공통되는 로직 Modifier로 빼기(LimitedTextLengthModifier - Binding이 제대로 안됨)
                            TextField("0", text: $store.firstInputCode)
                                .disableAutoFunctions()
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.center)
                                .font(.pretendard(kind: .heading_md, type: .bold))
                                .foregroundStyle(foregroundColor)
                                .frame(width: 72, height: 72)
                                .background(backgroundColor)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 12)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(borderLineColor, lineWidth: 2)
                                )
                                .onChange(of: store.firstInputCode) { _, inputText in
                                    if (inputText.count == 1) {
                                        textFieldFocusState = .second
                                    } else {
                                        store.firstInputCode = String(inputText.prefix(1))
                                    }
                                }
                                .focused($textFieldFocusState, equals: .first)
                            
                            Spacer()
                            
                            TextField("0", text: $store.secondInputCode)
                                .disableAutoFunctions()
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.center)
                                .font(.pretendard(kind: .heading_md, type: .bold))
                                .foregroundStyle(foregroundColor)
                                .frame(width: 72, height: 72)
                                .background(backgroundColor)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 12)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(borderLineColor, lineWidth: 2)
                                )
                                .onChange(of: store.secondInputCode) { _, inputText in
                                    
                                    if (inputText.count == 1) {
                                        textFieldFocusState = .third
                                    } else {
                                        if (inputText.count == 0) {
                                            textFieldFocusState = .first
                                        }
                                        store.secondInputCode = String(inputText.prefix(1))
                                        
                                    }
                                }
                                .focused($textFieldFocusState, equals: .second)
                            
                            Spacer()
                            
                            TextField("0", text: $store.thirdInputCode)
                                .disableAutoFunctions()
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.center)
                                .font(.pretendard(kind: .heading_md, type: .bold))
                                .foregroundStyle(foregroundColor)
                                .frame(width: 72, height: 72)
                                .background(backgroundColor)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 12)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(borderLineColor, lineWidth: 2)
                                )
                                .onChange(of: store.thirdInputCode) { _, inputText in
                                    
                                    if (inputText.count == 1) {
                                        textFieldFocusState = .fourth
                                    } else {
                                        if (inputText.count == 0) {
                                            textFieldFocusState = .second
                                        }
                                        store.thirdInputCode = String(inputText.prefix(1))
                                    }
                                }
                                .focused($textFieldFocusState, equals: .third)
                            
                            Spacer()
                            
                            TextField("0", text: $store.fourthInputCode)
                                .disableAutoFunctions()
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.center)
                                .font(.pretendard(kind: .heading_md, type: .bold))
                                .foregroundStyle(foregroundColor)
                                .frame(width: 72, height: 72)
                                .background(backgroundColor)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 12)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(borderLineColor, lineWidth: 2)
                                )
                                .onChange(of: store.fourthInputCode) { _, inputText in
                                    if (inputText.count == 0) {
                                        textFieldFocusState = .third
                                    } else {
                                        store.fourthInputCode = String(inputText.prefix(1))
                                    }
                                }
                                .focused($textFieldFocusState, equals: .fourth)
                        }
                        
                        if store.isInvalidInvitationCode {
                            Spacer()
                                .frame(height: 12)
                            Text("알맞지 않은 초대코드 입니다! 다시 확인해주세요.")
                                .font(.pretendard(kind: .body_md, type: .light))
                                .foregroundStyle(Color.mmRed)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 80)
                    .offset(y: keyboardHeight == 0 ? 0 : -60) // 키보드가 올라가면 적당한 높이만큼 위로 올리기.
                }
                
                VStack {
                    Spacer()
                    
                    MMRoundedButton(isEnabled: $store.isAllRequirementSatisfied, title: "확인") {
                        textFieldFocusState = nil
                        store.send(.confirmButtonTapped)
                    }
                    .frame(height: 60)
                    .padding(.bottom, 36)
                    .background(Color.white)
                    .offset(y: -keyboardHeight)
                }
                
                
                MMNavigationBar(
                    title: "초대코드 입력"
                ) {
                    store.send(.backButtonTapped)
                }
                
                // TODO: Toast Message Design System으로 빼기
                if showToastMessage {
                    VStack {
                        Spacer()
                        Text(store.toastErrorMessage)
                            .font(.pretendard(size: 14, type: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                Color.mmGray2
                                    .cornerRadius(9)
                            )
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, keyboardHeight + 111)
                    }
                    .transition(.opacity)
                    .zIndex(1)
                }
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .padding(.horizontal, 24)
        .makeTapToHideKeyboard()
        .animation(.default, value: keyboardHeight)
        .onAppear(perform: addKeyboardObserver)
        .onDisappear(perform: removeKeyboardObserver)
        .onChange(of: store.isUnavailableInvitation, { _, isUnavailableInvitation in
            if isUnavailableInvitation {
                showToastMessage = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        showToastMessage = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        store.isUnavailableInvitation = false
                    }
                }
            }
        })
        .overlay {
            if let store = store.scope(state: \.destination?.invitationConfirm, action: \.destination.invitationConfirm) {
                InvitationConfirmView(store: store)
            }
        }
    }
}

extension MissionInvitationCodeView {
    
    private var foregroundColor: Color {
        if store.isAllEmpty {
            return Color.mmDisabled
        } else {
            return Color.mmGray1
        }
    }
    
    private var backgroundColor: Color {
        if store.isAllEmpty {
            return Color.mmGray5
        } else {
            return Color.mmWhite
        }
    }
    
    private var borderLineColor: Color {
        if store.isInvalidInvitationCode {
            return Color.mmRed
        } else if store.isAllEmpty {
            return Color.mmWhite
        } else {
            return Color.mmGray4
        }
    }
    
    // TODO: 아래 attributed text로 하는 방법으로 바꾸기 (재사용가능하게)
    var invitationCodeHeaderView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("친구에게 전송받은")
            HStack(alignment: .top, spacing: 0) {
                Text("초대코드 4자리")
                    .foregroundStyle(Color.mmOrange)
                Text("를 입력해주세요!")
            }
        }
        .font(.pretendard(kind: .title_xl, type: .light))
    }
    
    // MARK: 키보드 올라가는 이벤트 체킹
    private func highlightedTextView(text: String, highlightTexts: [String]) -> some View {
        var attributedString = AttributedString(text)
        
        for highlightText in highlightTexts {
            if let range = attributedString.range(of: highlightText) {
                attributedString[range].foregroundColor = .mmOrange
                attributedString[range].font = .pretendard(kind: .title_xl, type: .medium)
            }
        }
        return Text(attributedString)
    }
    
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
