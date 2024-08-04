import SwiftUI
import Foundation
import ComposableArchitecture
import DomainMissionInterface
import DomainBoardInterface
import DomainPlayerInterface
import DomainCompetitionInterface
import SharedThirdPartyLib

@Reducer
public struct HomeFeature {
    
    @ObservableState
    public struct State {
        public var mission: Mission
        public var competition: Competition
        public var certificationButtonState: CertificationButtonState
        
        @Shared(.appStorage("isInvitationGuideToolTipShowed")) var isInvitationGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isMissionInfoGuideToolTipShowed")) var isMissionInfoGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isCertificationImageGuideToolTipShowed")) var isCertificationImageGuideToolTipShowed: Bool = false
        
        public init() {
            let theme: JejuIslandBoardTheme = .init()
            let mission: Mission = .init(description: "매일 유산소 1시간")
            let isDisabled = true
            let competition: Competition = .init(
                players: [
                    .init(id: "1", pieceID: "1", name: "이해석", character: .rabbit, isMe: true),
                    .init(id: "2", pieceID: "2", name: "김용재", character: .rabbit)
                ],
                board: .init(
                    theme: theme,
                    events: [.item(.init(image: "", position: Position(index: 2), description: "단감 먹기"))],
                    pieces: [
                        .init(id: "1", position: Position(index: 0)),
                        .init(id: "2", position: Position(index: 1))
                    ],
                    totalBlockCount: 25,
                    conqueredIndex: 11,
                    isDisabled: isDisabled
                ),
                info: [
                    .title: "경쟁시작 8월 15일",
                    .subtitle: "해당일에 자동으로 경쟁 시작합니다."
                ]
            )
            self.mission = mission
            self.competition = competition
            self.certificationButtonState = .init(isEnabled: false, info: "미션 요일: 월 화 수 목 금 토", title: "오늘 미션 인증하기")
        }
    }
    
    public enum Action {
        case onAppear
        case didTapMissionInfoButton
        case didTapSettingButton
        case didTapInvitationInfoButton
        case didTapInvitatoinInfoToolTip
        case didTapMissionInfoGuideToolTip
        case didTapPlayer(player: Player)
        case didTapCertificationButton
        case didTapPiece(piece: Piece)
        case movePiece(piece: Piece, to: Position)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none

            case .didTapMissionInfoButton:
                return .none
            case .didTapSettingButton:
                return .none
            case .didTapPlayer(player: let player):
                return .none
            case .didTapCertificationButton:
                return .none
            case .didTapPiece(piece: let piece):
                return .none
            case .movePiece(piece: let piece, to: let to):
                return .none
            case .didTapInvitationInfoButton:
                return .none
            case .didTapInvitatoinInfoToolTip:
                return .none
            case .didTapMissionInfoGuideToolTip:
                return .none
            }
        }
    }
    
    public init() {}
}

public extension HomeFeature {
    
    struct CertificationButtonState {
        let isEnabled: Bool
        let info: String
        let title: String
    }
}
