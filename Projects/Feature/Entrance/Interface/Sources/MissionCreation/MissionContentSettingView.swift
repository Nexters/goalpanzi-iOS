import SwiftUI
import SharedDesignSystem

public struct MissionContentSettingView: View {
    @State var text: String = ""
    @State var isValidInputText: Bool = true
    @State var noticeMessage: String? = "4~12자 이내로 입력하세요."
    @State var isEnabled: Bool = true
    @State private var keyboardHeight: CGFloat = 0

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 22)

                    highlightedTextView(
                        text: "경쟁인원은\n최소 2명에서 최대 10명이에요!",
                        highlightTexts: ["최소 2명", "최대 10명"]
                    )
                    .foregroundStyle(Color.mmGray1)
                    .font(.pretendard(kind: .title_xl, type: .light))

                    Spacer()
                        .frame(height: 60)

                    Text("미션")
                        .foregroundStyle(Color.mmGray2)
                        .font(.pretendard(kind: .body_md, type: .bold))

                    MMTextField(
                        text: $text,
                        isValidInputText: $isValidInputText,
                        noticeMessage: $noticeMessage,
                        placeholder: "ex) 주3회 러닝하기 / 매일 책3장씩 읽기"
                    )

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 80)
                .offset(y: keyboardHeight == 0 ? 0 : -60)
                
                VStack {
                    Spacer()

                    MMRoundedButton(isEnabled: $isEnabled, title: "다음") {
                        print("Good")
                    }
                    .frame(height: 60)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 36)
                    .background(Color.white)
                    .offset(y: -keyboardHeight)
                }

                MMNavigationBar(
                    title: "미션 설정",
                    navigationAccessoryItem: AnyView(MMCapsuleTagView(
                        text: "1/3",
                        font: .pretendard(kind: .body_xl, type: .medium),
                        horizontalPadding: 14,
                        verticalPadding: 1
                    ))
                ) {
                    print("backButtonTapped")
                }
                .padding(.horizontal, 24)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .animation(.default, value: keyboardHeight)
        .onAppear(perform: addKeyboardObserver)
        .onDisappear(perform: removeKeyboardObserver)
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
