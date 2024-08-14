//
//  InformationView.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/14/24.
//

import SwiftUI

import SharedDesignSystem


public struct InformationView: View {
    
    public enum Information: String {
        case privacyPolicy = "개인정보 취급 방침"
        case termsOfUse = "서비스 이용약관"
        
        public var description: String {
            switch self {
            case .privacyPolicy:
                return """
                제1조 (목적).\n
                미션메이트(이하 "회사")는 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호 등에 관한 법률", "개인정보 보호법" 등 관련 법령을 준수하기 위하여 개인정보 취급 방침을 제정하고 이를 준수하고 있습니다. 본 개인정보 취급 방침은 회사가 제공하는 서비스(이하 "서비스")에 적용됩니다. 서비스 이용자(이하 "이용자")의 개인정보를 보호하며, 이용자가 서비스를 이용함과 동시에 온라인상에서 회사에 제공한 개인정보가 보호받을 수 있도록 최선을 다하고 있습니다. 본 개인정보 취급 방침은 다음과 같은 내용을 담고 있습니다.\n
                1. 수집하는 개인정보의 항목.\n
                2. 개인정보의 수집 및 이용 목적.\n
                3. 개인정보의 보유 및 이용 기간.\n
                4. 개인정보의 파기 절차 및 방법.\n
                5. 개인정보 제공.\n
                6. 이용자 및 법정대리인의 권리와 그 행사 방법.\n
                7. 개인정보 자동 수집 장치의 설치/운영 및 거부에 관한 사항.\n
                8. 개인정보의 기술적/관리적 보호 대책.\n

                제2조 (수집하는 개인정보의 항목).\n
                회사는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.\n
                  1. 수집 항목: 이름, 생년월일, 성별, 로그인ID, 비밀번호, 휴대전화번호, 이메일, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보.\n
                  2. 개인정보 수집 방법: 홈페이지(회원가입), 생성 정보 수집 툴을 통한 수집.\n

                제3조 (개인정보의 수집 및 이용 목적).\n
                회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.\n
                  1. 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산: 콘텐츠 제공, 구매 및 요금 결제, 금융거래 본인 인증 및 금융 서비스.\n
                  2. 회원 관리: 회원제 서비스 이용에 따른 본인확인, 개인 식별, 불량 회원의 부정 이용 방지와 비인가 사용 방지, 가입 의사 확인, 연령 확인, 만 14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 고지사항 전달.\n

                제4조 (개인정보의 보유 및 이용 기간).\n
                회사는 원칙적으로, 개인정보 수집 및 이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.\n
                  1. 회사 내부 방침에 의한 정보 보유 사유.\n
                    1.1. 부정거래 방지 및 운영방침 위반 회원에 대한 기록: 1년.\n
                  2. 관련 법령에 의한 정보 보유 사유.\n
                    2.1. 계약 또는 청약철회 등에 관한 기록: 5년 (전자상거래 등에서의 소비자보호에 관한 법률).\n
                    2.2. 대금 결제 및 재화 등의 공급에 관한 기록: 5년 (전자상거래 등에서의 소비자보호에 관한 법률).\n
                    2.3. 소비자의 불만 또는 분쟁 처리에 관한 기록: 3년 (전자상거래 등에서의 소비자보호에 관한 법률).\n
                    2.4. 본인확인에 관한 기록: 6개월 (정보통신망 이용촉진 및 정보보호 등에 관한 법률).\n
                    2.5. 방문에 관한 기록: 3개월 (통신비밀보호법).\n

                제5조 (개인정보의 파기 절차 및 방법).\n
                회사는 원칙적으로 개인정보 처리 목적이 달성된 경우에는 지체 없이 해당 개인정보를 파기합니다. 파기 절차 및 방법은 다음과 같습니다.\n
                  1. 파기 절차.\n
                    이용자가 입력한 정보는 목적 달성 후 별도의 DB로 옮겨져 (종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라 (보유 및 이용 기간 참조) 일정 기간 저장된 후 파기됩니다. 별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.\n
                  2. 파기 방법.\n
                    전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다. 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통해 파기합니다.\n

                제6조 (개인정보 제공).\n
                회사는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.\n
                  1. 이용자가 사전에 동의한 경우.\n
                  2. 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우.\n

                제7조 (이용자 및 법정대리인의 권리와 그 행사 방법).\n
                  1. 이용자 및 법정 대리인은 언제든지 등록되어 있는 자신 혹은 당해 만 14세 미만 아동의 개인정보를 조회하거나 수정할 수 있으며 가입 해지를 요청할 수도 있습니다.\n
                  2. 이용자 혹은 만 14세 미만 아동의 개인정보 조회/수정을 위해서는 ‘개인정보변경’(또는 ‘회원정보수정’ 등)을, 가입 해지(동의 철회)를 위해서는 ‘회원탈퇴’를 클릭하여 본인 확인 절차를 거치신 후 직접 열람, 정정 또는 탈퇴가 가능합니다.\n
                  3. 혹은 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체 없이 조치하겠습니다.\n
                  4. 귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다.\n
                  5. 또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리 결과를 제3자에게 지체 없이 통지하여 정정이 이루어지도록 하겠습니다.\n

                제8조 (개인정보 자동 수집 장치의 설치/운영 및 거부에 관한 사항).\n
                회사는 귀하의 정보를 수시로 저장하고 찾아내는 ‘쿠키(cookie)’ 등을 운용합니다. 쿠키란 웹사이트를 운영하는데 이용되는 서버가 귀하의 브라우저에 보내는 아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드디스크에 저장됩니다. 회사는 다음과 같은 목적을 위해 쿠키를 사용합니다.\n
                  1. 쿠키 등 사용 목적.\n
                    1.1. 이용자들의 접속 빈도나 방문 시간 등을 분석, 이용자 취향 및 관심분야를 파악 및 자취 추적, 각종 이벤트 참여 정도 및 방문 회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서비스 제공.\n
                    1.2. 귀하는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서, 귀하는 웹 브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다.\n
                  2. 쿠키 설정 거부 방법.\n
                    2.1. 예: 쿠키 설정을 거부하는 방법으로는 귀하가 사용하는 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다.\n
                    2.2. 설정방법 예(인터넷 익스플로러의 경우): 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보.\n
                    2.3. 단, 귀하께서 쿠키 설치를 거부하였을 경우 서비스 제공에 어려움이 있을 수 있습니다.\n

                제9조 (개인정보의 기술적/관리적 보호 대책).\n
                회사는 이용자의 개인정보를 처리함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 안전성 확보를 위해 다음과 같은 기술적/관리적 대책을 강구하고 있습니다.\n
                  1. 비밀번호 암호화.\n
                    이용자의 개인정보는 비밀번호는 암호화되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.\n
                """

                
            case .termsOfUse:
                return """
                제1조 (목적).\n
                미션메이트(이하 “회사”)는 개인정보를 중요시하며, “정보통신망 이용촉진 및 정보보호 등에 관한 법률”, “개인정보 보호법”, “신용정보의 이용 및 보호에 관한 법률” 등 모든 관련 법령을 준수하기 위하여 개인정보 처리방침을 제정하고 이를 준수하고 있습니다. 본 개인정보 처리방침은 회사가 제공하는 서비스(모바일 애플리케이션, 이메일 또는 고객센터를 통한 상담 및 기타)에 적용됩니다.\n
                회사는 이용자의 개인정보를 처리함에 있어 관련 법령에 근거하여 고지 또는 동의 받은 범위 내에서 최소한으로 수집 및 이용하며, 이용자의 권익 보호를 위해 최선을 다할 것입니다.\n
                이용자의 개인정보 보호 관련 문의는 아래 연락처로 문의할 수 있습니다.\n
                - 이메일: missionmateteam@gmail.com\n
                - 주소: 경기도 성남시 분당구 대왕판교로 256번길 25, 판교알파리움 A동 9층.\n

                제2조 (개인정보의 수집 및 이용 목적).\n
                회사는 다음과 같은 목적을 위해 개인정보를 수집, 이용하고 있습니다.\n
                  1. 회원 가입 및 관리: 회원 가입 의사 확인, 회원제 서비스 제공, 서비스 부정 이용 방지.\n
                  2. 서비스 제공: 콘텐츠 제공, 특정 맞춤 서비스 제공, 본인인증.\n
                  3. 고객 상담: 고객 문의 및 민원 처리.\n
                  4. 서비스 개선: 서비스 개선 및 개발을 위한 내부 통계 및 분석.\n
                  5. 마케팅 및 광고: 맞춤형 광고 제공 및 이벤트 정보 제공.\n

                제3조 (수집하는 개인정보).\n
                회사는 다음과 같은 개인정보를 수집합니다.\n
                  1. 수집 항목.\n
                    1.1. 회원가입 시: 이메일 주소, 비밀번호, 이름, 닉네임.\n
                    1.2. 서비스 이용 시: IP 주소, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록.\n

                제4조 (개인정보의 보유 및 이용 기간).\n
                회사는 법령에 따른 개인정보 보유·이용 기간 또는 이용자로부터 개인정보를 수집 시에 동의 받은 개인정보 보유·이용 기간 내에서 개인정보를 처리·보유합니다.\n
                  1. 계약 또는 청약철회 등에 관한 기록: 5년.\n
                  2. 대금 결제 및 재화 등의 공급에 관한 기록: 5년.\n
                  3. 소비자의 불만 또는 분쟁 처리에 관한 기록: 3년.\n
                  4. 본인확인에 관한 기록: 6개월.\n
                  5. 웹사이트 방문 기록: 3개월.\n

                제5조 (개인정보의 파기).\n
                회사는 원칙적으로 개인정보 처리 목적이 달성된 경우에는 지체 없이 해당 개인정보를 파기합니다.\n
                파기의 절차 및 방법은 다음과 같습니다.\n
                  1. 파기 절차.\n
                    이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져 내부 방침 및 기타 관련 법령에 따라 일정 기간 저장된 후 또는 즉시 파기됩니다.\n
                  2. 파기 방법.\n
                    전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.\n

                제6조 (개인정보의 안전성 확보 조치).\n
                회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 하고 있습니다.\n
                  1. 개인정보의 암호화.\n
                    이용자의 개인정보는 비밀번호는 암호화되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.\n
                  2. 해킹 등에 대비한 기술적 대책.\n
                    회사는 해킹이나 컴퓨터 바이러스 등에 의해 이용자의 개인정보가 유출되거나 훼손되는 것을 막기 위해 최선을 다하고 있습니다.\n

                공고일자: 2024년 8월 3일.\n
                시행일자: 2024년 8월 3일.
                """
            }
        }
    }
    
    private let type: Information
    
    @Environment(\.dismiss) private var dismiss
    
    public init(type: Information) {
        self.type = type
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MMNavigationBar(
                title: type.rawValue
            ) {
                dismiss()
            }
            .padding(.bottom, 22)
            
            ScrollView(showsIndicators: false) {
                Text(type.description)
                    .lineSpacing(3)
                    .foregroundStyle(Color.mmGray1)
                    .font(.pretendard(kind: .body_md, type: .light))
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .padding(.horizontal, 24)
    }
}