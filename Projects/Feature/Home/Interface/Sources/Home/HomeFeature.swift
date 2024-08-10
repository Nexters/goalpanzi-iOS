import Foundation
import UIKit
import ComposableArchitecture
import DomainMissionInterface
import DomainBoardInterface
import DomainPlayerInterface
import DomainCompetitionInterface
import SharedDesignSystem
import SharedThirdPartyLib

@Reducer
public struct HomeFeature {
    
    @ObservableState
    public struct State {
        public var mission: Mission
        public var competition: Competition
        public var certificationButtonState: CertificationButtonState
        public var shouldStartAnimation: Bool
        public var selectedImages: [UIImage]
        
        @Shared(.appStorage("isInvitationGuideToolTipShowed")) var isInvitationGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isMissionInfoGuideToolTipShowed")) var isMissionInfoGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isCertificationImageGuideToolTipShowed")) var isCertificationImageGuideToolTipShowed: Bool = false
        
        @Presents var destination: Destination.State?
        var path = StackState<Path.State>()
        
        public init() {
            let theme: JejuIslandBoardTheme = .init()
            let mission: Mission = .init(description: "매일 유산소 1시간")
            let competitionState: Competition.State = .notStarted(hasOtherPlayer: false)//.started//
            let isDisabled = competitionState != .started
            let competition: Competition = .init(
                players: [
                    .init(id: "1", pieceID: "1", name: "이해석", character: .rabbit, isMe: true),
//                    .init(id: "2", pieceID: "2", name: "김용재", character: .bear),
//                    .init(id: "3", pieceID: "3", name: "김용재2", character: .cat),
                ],
                board: .init(
                    theme: theme,
                    events: [
                        .reward(JejuRewardInfo(rawValue: "ORANGE", position: Position(index: 1), description: "감귤 먹기")),
                        .reward(JejuRewardInfo(rawValue: "CANOLA_FLOWER", position: Position(index: 3), description: "유채꽃 보기")),
                        .reward(JejuRewardInfo(rawValue: "DOLHARUBANG", position: Position(index: 6), description: "돌하르방 만나기")),
                        .reward(JejuRewardInfo(rawValue: "HORSE_RIDING", position: Position(index: 9), description: "승마 체험하기")),
                        .reward(JejuRewardInfo(rawValue: "HALLA_MOUNTAIN", position: Position(index: 13), description: "한라산 등반하기")),
                        .reward(JejuRewardInfo(rawValue: "WATERFALL", position: Position(index: 17), description: "폭포 감상하기")),
                        .reward(JejuRewardInfo(rawValue: "BLACK_PIG", position: Position(index: 21), description: "흑돼지 먹기")),
                        .reward(JejuRewardInfo(rawValue: "SUNRISE", position: Position(index: 25), description: "성산일출봉 보기")),
                        .reward(JejuRewardInfo(rawValue: "GREEN_TEA_FIELD", position: Position(index: 29), description: "녹차밭")),
                        .reward(JejuRewardInfo(rawValue: "BEACH", position: Position(index: 31), description: "바다 보기"))
                    ],
                    totalBlockCount: 33,
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
            self.selectedImages = []
            
            let piece = competition.myPiece!
            let newPiece = Piece(id: piece.id, position: piece.position + 9, image: piece.image, name: piece.name)
            self.competition.board.remove(piece: piece)
            self.competition.board.insert(piece: newPiece)
            self.competition.board.update(conqueredIndex: newPiece.position.index)
        }
    }
    
    @Reducer
    public enum Destination {
        case missionInvitationInfo(MissionInvitationInfoFeature)
        case missionDeleteAlert(MissionDeleteAlertFeature)
        case certificationResult(CertificationResultFeature)
        case eventResult(EventResultFeature)
        case imageUpload(ImageUploadFeature)
        case imageDetail(ImageDetailFeature)
    }
    
    @Reducer
    public enum Path {
        case missionInfo(MissionInfoFeature)
    }
    
    public enum Action: BindableAction {
        case onAppear
        case didTapMissionInfoButton
        case didTapSettingButton
        case didTapInvitationInfoButton
        case didTapInvitationInfoToolTip
        case didTapMissionInfoGuideToolTip
        case didTapPlayer(player: Player)
        case didSelectImages([UIImage])
        case didTapPiece(piece: Piece)
        case movePiece(piece: Piece, to: Position)
        case destination(PresentationAction<Destination.Action>)
        case path(StackActionOf<Path>)
        case binding(BindingAction<State>)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .didTapMissionInfoButton:
                state.isMissionInfoGuideToolTipShowed = true
                state.path.append(.missionInfo(MissionInfoFeature.State()))
                return .none
            case .didTapSettingButton:
                state.destination = .imageDetail(ImageDetailFeature.State())
                return .none
            case .didTapPlayer(player: let player):
                return .none
            case let .didSelectImages(images):
                print(state.selectedImages)
                return .none
            case .didTapPiece(piece: let piece):
                return .none
            case .movePiece(piece: let piece, to: let to):
                return .none
            case .didTapInvitationInfoButton:
                state.isInvitationGuideToolTipShowed = true
                state.destination = .missionInvitationInfo(MissionInvitationInfoFeature.State(codes: ["A", "Z", "3", "X"]))
                return .none
            case .didTapInvitationInfoToolTip:
                state.isInvitationGuideToolTipShowed = true
                return .none
            case .didTapMissionInfoGuideToolTip:
                state.isMissionInfoGuideToolTipShowed = true
                return .none
            case .destination:
                return .none
            case .path:
                return .none
            case .binding:
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
