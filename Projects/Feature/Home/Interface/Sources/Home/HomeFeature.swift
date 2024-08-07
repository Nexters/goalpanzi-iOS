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
        public var shouldStartAnimation: Bool
        
        @Shared(.appStorage("isInvitationGuideToolTipShowed")) var isInvitationGuideToolTipShowed: Bool = true
        @Shared(.appStorage("isMissionInfoGuideToolTipShowed")) var isMissionInfoGuideToolTipShowed: Bool = true
        @Shared(.appStorage("isCertificationImageGuideToolTipShowed")) var isCertificationImageGuideToolTipShowed: Bool = true
        
        @Presents var destination: Destination.State?
        var path = StackState<Path.State>()
        
        public init() {
            let theme: JejuIslandBoardTheme = .init()
            let mission: Mission = .init(description: "매일 유산소 1시간")
            let competitionState: Competition.State = .started//.notStarted(hasOtherPlayer: true)
            let isDisabled = competitionState != .started
            let competition: Competition = .init(
                players: [
                    .init(id: "1", pieceID: "1", name: "이해석", character: .rabbit, isMe: true),
                    .init(id: "2", pieceID: "2", name: "김용재", character: .bear)
                ],
                board: .init(
                    theme: theme,
                    events: [.item(.init(image: "", position: Position(index: 2), description: "단감 먹기"))],
                    totalBlockCount: 19,
                    conqueredIndex: 1,
                    isDisabled: isDisabled
                ),
                info: [
                    .title: "경쟁시작 8월 15일",
                    .subtitle: "해당일에 자동으로 경쟁 시작합니다."
                ], 
                state: competitionState
            )
            self.mission = mission
            self.competition = competition
            self.certificationButtonState = .init(isEnabled: !isDisabled, info: "미션 요일: 월 화 수 목 금 토", title: "오늘 미션 인증하기")
            self.shouldStartAnimation = false
        }
    }
    
    @Reducer
    public enum Destination {
        case missionInvitationInfo(MissionInvitationInfoFeature)
        case missionDeleteAlert(MissionDeleteAlertFeature)
        case certificationResult(CertificationResultFeature)
        case eventResult(EventResultFeature)
    }
    
    @Reducer
    public enum Path {
        case missionInfo(MissionInfoFeature)
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
        case destination(PresentationAction<Destination.Action>)
        case path(StackActionOf<Path>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none

            case .didTapMissionInfoButton:
                state.path.append(.missionInfo(MissionInfoFeature.State()))
                return .none
            case .didTapSettingButton:
                state.destination = .certificationResult(CertificationResultFeature.State())
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
                state.destination = .missionInvitationInfo(MissionInvitationInfoFeature.State())
                return .none
            case .didTapInvitatoinInfoToolTip:
                state.isInvitationGuideToolTipShowed = true
                return .none
            case .didTapMissionInfoGuideToolTip:
                state.isMissionInfoGuideToolTipShowed = true
                return .none
            case .destination:
                return .none
            case .path:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
        .forEach(\.path, action: \.path)
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
