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
        public var selectedImages: [UIImage]
        public var movingPiece: Piece? = nil
        
        @Shared(.appStorage("isInvitationGuideToolTipShowed")) var isInvitationGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isMissionInfoGuideToolTipShowed")) var isMissionInfoGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isCertificationImageGuideToolTipShowed")) var isCertificationImageGuideToolTipShowed: Bool = false
        
        @Presents var destination: Destination.State?
        public var path = StackState<Path.State>()
        
        public init() {
            let startDate = "2024-08-13 16:30"
            let endDate = "2025-08-13 16:30"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            let theme: JejuIslandBoardTheme = .init()
            let mission: Mission = .init(
                description: "매일 유산소 1시간",
                startDate: dateFormatter.date(from: startDate) ?? Date.now,
                endDate: dateFormatter.date(from: endDate) ?? Date.now
            )
            let competitionState: Competition.State = .started//.notStarted(hasOtherPlayer: true)//.notStarted(hasOtherPlayer: false)//.started//
            let isDisabled = competitionState != .started
            var competition: Competition = .init(
                players: [
                    .init(id: "1", pieceID: "1", name: "이해석", character: .rabbit, isMe: true),
                    .init(id: "2", pieceID: "2", name: "김용재", character: .bear),
                    .init(id: "3", pieceID: "3", name: "김용재2", character: .cat),
                    .init(id: "4", pieceID: "4", name: "김용재3", character: .panda),
                    .init(id: "5", pieceID: "5", name: "김용재4", character: .dog),
                    .init(id: "6", pieceID: "6", name: "김용재5", character: .dog),
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
                    conqueredPosition: .zero,
                    isDisabled: isDisabled
                ),
                info: [
                    .title: "경쟁시작 8월 15일",
                    .subtitle: "해당일에 자동으로 경쟁 시작합니다."
                ], 
                state: competitionState
            )
            self.mission = mission
            
            let piece1 = competition.board.findPiece(by: "2")
            competition.board.update(piece: piece1!, to: Position(index: 1))
            
            let piece2 = competition.board.findPiece(by: "6")
            competition.board.update(piece: piece2!, to: Position(index: 7))
            
            let myPiece = competition.myPiece
            competition.board.update(piece: myPiece!, to: Position(index: 5))
            competition.board.update(conqueredPosition: Position(index: 5))
            
            
            competition.certify(playerID: "2", imageURL: "https://picsum.photos/400/500")
            
            
            self.competition = competition
            self.certificationButtonState = .init(isEnabled: !isDisabled, info: "미션 요일: 월 화 수 목 금 토", title: "오늘 미션 인증하기")
            self.selectedImages = []
            
        }
    }
    
    @Reducer
    public enum Destination {
        case missionInvitationInfo(MissionInvitationInfoFeature)
        case missionDeleteAlert(MissionDeleteAlertFeature)
        case certificationResult(CertificationResultFeature)
        case eventResult(MissionResultFeature)
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
        case didFinishMoving(piece: Piece?)
        case destination(PresentationAction<Destination.Action>)
        case path(StackActionOf<Path>)
        case binding(BindingAction<State>)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                if state.competition.state == .notStarted(hasOtherPlayer: false)
                    && state.mission.startDate < Date.now {
                    state.destination = .missionDeleteAlert(MissionDeleteAlertFeature.State())
                    return .none
                }
                
                return .none
            case .didTapMissionInfoButton:
                state.isMissionInfoGuideToolTipShowed = true
                state.path.append(.missionInfo(MissionInfoFeature.State()))
                return .none
            case .didTapSettingButton:
                return .none
            case .didTapPlayer(player: let player):
                guard player.isCertificated, let certification = state.competition.findCertification(by: player.id) else { return .none }
                state.destination = .imageDetail(ImageDetailFeature.State(player: player, updatedDate: certification.updatedAt, imageURL: certification.imageURL))
                return .none
            case let .didSelectImages(images):
                guard let image = images.first, let me = state.competition.me else { return .none }
                state.destination = .imageUpload(ImageUploadFeature.State(player: me, selectedImage: image))
                return .none
            case .didTapPiece(piece: let piece):
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
            case let .destination(action):
                switch action {
                case .dismiss:
                    return .none
                case .presented(.imageUpload(.didFinishImageUpload)):
                    guard let myPiece = state.competition.myPiece else { return .none }
                    let newPosition = myPiece.position + 1
                    guard newPosition.index < state.competition.board.totalBlockCount else {
                        // <경쟁종료됨>
                        // 경쟁종료화면으로 이동
                        return .none
                    }
                    let event = state.competition.board.findEvent(by: newPosition)
                    state.destination = .certificationResult(CertificationResultFeature.State(event: event))
                    return .none
                case .presented(.certificationResult(.didTapCloseButton)):
                    guard let myPiece = state.competition.myPiece else { return .none }
                    state.movingPiece = myPiece
                    state.competition.board.remove(piece: myPiece)
                    return .none
                case .presented(_):
                    return .none
                }
            case let .didFinishMoving(myPiece):
                guard let myPiece else { return .none }
                let newPosition = myPiece.position + 1
                state.competition.board.update(piece: myPiece, to: newPosition)
                state.competition.board.update(conqueredPosition: newPosition)
                state.movingPiece = nil
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
