//
//  MissionInvitationCodeView.swift
//  FeatureEntrance
//
//  Created by Miro on 8/8/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct MissionInvitationCodeView: View {

    @Bindable public var store: StoreOf<MissionInvitationCodeFeature>

    public init(store: StoreOf<MissionInvitationCodeFeature>) {
        self.store = store
    }

    enum FocusTextField {
        case first
        case second
        case third
        case fourth
    }

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
                            TextField("0", text: $store.firstInputCode)
                                .modifier(LimitedTextLengthModifier(
                                    inputText: $store.firstInputCode,
                                    isAllInvalid: $store.isInvalid,
                                    isAllEmpty: $store.isAllEmpty
                                ))
                                .onChange(of: store.firstInputCode) { _, inputText in
                                    if (inputText.count == 1) {
                                        textFieldFocusState = .second
                                    }
                                }
                                .focused($textFieldFocusState, equals: .first)

                            Spacer()

                            TextField("0", text: $store.secondInputCode)
                                .modifier(LimitedTextLengthModifier(
                                    inputText: $store.secondInputCode,
                                    isAllInvalid: $store.isInvalid,
                                    isAllEmpty: $store.isAllEmpty
                                ))
                                .onChange(of: store.secondInputCode) { _, inputText in
                                    if (inputText.count == 1) {
                                        textFieldFocusState = .third
                                    } else {
                                        if (inputText.count == 0) {
                                            textFieldFocusState = .first
                                        }
                                    }
                                }
                                .focused($textFieldFocusState, equals: .second)

                            Spacer()

                            TextField("0", text: $store.thirdInputCode)
                                .modifier(LimitedTextLengthModifier(
                                    inputText: $store.thirdInputCode,
                                    isAllInvalid: $store.isInvalid,
                                    isAllEmpty: $store.isAllEmpty
                                ))
                                .onChange(of: store.thirdInputCode) { _, inputText in
                                    if (inputText.count == 1) {
                                        textFieldFocusState = .fourth
                                    } else {
                                        if (inputText.count == 0) {
                                            textFieldFocusState = .second
                                        }
                                    }
                                }
                                .focused($textFieldFocusState, equals: .third)

                            Spacer()

                            TextField("0", text: $store.fourthInputCode)
                                .modifier(LimitedTextLengthModifier(
                                    inputText: $store.fourthInputCode,
                                    isAllInvalid: $store.isInvalid,
                                    isAllEmpty: $store.isAllEmpty
                                ))
                                .onChange(of: store.fourthInputCode) { _, inputText in
                                    if (inputText.count == 0) {
                                        textFieldFocusState = .third
                                    }
                                }
                                .focused($textFieldFocusState, equals: .fourth)
                        }

                        if store.isInvalid {
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

                    MMRoundedButton(isEnabled: $store.isAllTexFieldFilled, title: "확인") {
                        store.send(.confirmButtonTapped)
                    }
                    .frame(height: 60)
                    .padding(.bottom, 36)
                    .background(Color.white)
                    .offset(y: -keyboardHeight)
                }


                MMNavigationBar(
                    title: "초대코드 입력",
                    navigationAccessoryItem: AnyView(MMCapsuleTagView(
                        text: "2/3",
                        font: .pretendard(kind: .body_xl, type: .medium),
                        horizontalPadding: 14,
                        verticalPadding: 1
                    ))
                ) {
                    store.send(.backButtonTapped)
                }
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .padding(.horizontal, 24)
        .animation(.default, value: keyboardHeight)
        .onAppear(perform: addKeyboardObserver)
        .onDisappear(perform: removeKeyboardObserver)
    }
}

extension MissionInvitationCodeView {

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
