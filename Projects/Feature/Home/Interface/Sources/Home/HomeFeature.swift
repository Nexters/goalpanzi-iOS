import Foundation
import UIKit
import ComposableArchitecture
import DomainMissionInterface
import DomainUserInterface
import DomainBoardInterface
import DomainPlayerInterface
import DomainCompetitionInterface
import SharedDesignSystem
import SharedThirdPartyLib
import DataRemoteInterface
import DataRemote

@Reducer
public struct HomeFeature {
    
    @Dependency(MissionService.self) var missionService
    @Dependency(MissionBoardService.self) var missionBoardService
    @Dependency(MissionMemberService.self) var missionMemberService
    @Dependency(MissionVerificationService.self) var missionVerificationService
    
    @ObservableState
    public struct State {
        public var mission: Mission? = nil
        public var competition: Competition? = nil
        public var certificationButtonState: CertificationButtonState = .init(isEnabled: false, info: "", title: "")
        public var selectedImages: [UIImage] = []
        public var movingPiece: Piece? = nil
        
        public var me: Player? = nil
        public var missionId: Int? = nil
        
        @Shared(.appStorage("isInvitationGuideToolTipShowed")) var isInvitationGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isMissionInfoGuideToolTipShowed")) var isMissionInfoGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isCertificationImageGuideToolTipShowed")) var isCertificationImageGuideToolTipShowed: Bool = false
        
        @Presents var destination: Destination.State?
        public var path = StackState<Path.State>()
        
        public init() {
        
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
        
        case didFetchMyMissionInfo(MyMissionInfo)
        case didFetchMissionAndBoard(Mission, MissionBoard)
        case error(Error)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    do {
                        let myMissionInfo = try await missionMemberService.getMissionMembersMe()
                        await send(.didFetchMyMissionInfo(myMissionInfo))
                    } catch {
                        await send(.error(error))
                    }
                }
            case let .didFetchMyMissionInfo(myMissionInfo):
                state.me = Player(
                    id: myMissionInfo.profile.nickname,
                    pieceID: myMissionInfo.profile.nickname,
                    name: myMissionInfo.profile.nickname,
                    character: DomainUserInterface.Character(rawValue: myMissionInfo.profile.characterType) ?? .rabbit
                )
                state.missionId = myMissionInfo.missions.first?.missionId
                return .run { [missionId = state.missionId] send in
                    do {
                        guard let missionId else { throw NSError() }
                        async let mission = try missionService.getMissions(missionId)
                        async let board = try missionBoardService.getBoard(missionId)
                        let (missionResult, boardResult): (Mission, MissionBoard) = try await (mission, board)
                        await send(.didFetchMissionAndBoard(missionResult, boardResult))
                    } catch {
                        print(error)
                    }
                }
            case let .didFetchMissionAndBoard(mission, board):
                state.mission = mission
                
                let players: [Player] = board.missionBoards.flatMap(\.missionBoardMembers).map {
                    Player(id: $0.nickname, pieceID: $0.nickname, name: $0.nickname, character: Character(rawValue: $0.characterType) ?? .rabbit, isMe: state.me?.name == $0.nickname)
                }
                
                
                let events: [Event] = board.missionBoards.map {
                    Event.reward(JejuRewardInfo(rawValue: $0.reward, position: Position(index: $0.number)))
                }
                
                let theme: JejuIslandBoardTheme = JejuIslandBoardTheme()
                
                let competitionState: Competition.State = {
                    if mission.missionStartDate >= Date.now, players.count == 1 {
                        return .disabled
                    }
                    if mission.missionStartDate >= Date.now, players.count > 1 {
                        return .started
                    }
                    if mission.missionStartDate < Date.now, players.count == 1 {
                        return .notStarted(hasOtherPlayer: false)
                    }
                    if mission.missionStartDate < Date.now, players.count > 1 {
                        return .notStarted(hasOtherPlayer: true)
                    }
                    return .disabled
                }()
                
                var competition = Competition(
                    players: players,
                    board: Board(
                        theme: theme,
                        events: events,
                        totalBlockCount: mission.boardCount,
                        isDisabled: competitionState != .started
                    ),
                    info: [
                        .title: "경쟁시작 8월 15일",
                        .subtitle: "해당일에 자동으로 경쟁 시작합니다."
                    ],
                    state: competitionState
                )
                
                board.missionBoards.forEach { boardInfo in
                    boardInfo.missionBoardMembers.forEach { member in
                        guard let piece = competition.board.findPiece(by: member.nickname) else { return }
                        competition.board.update(piece: piece, to: Position(index: boardInfo.number))
                        if piece == competition.myPiece {
                            competition.board.update(conqueredPosition: Position(index: boardInfo.number))
                        }
                    }
                }
                
                state.competition = competition
                state.certificationButtonState = {
                    if competition.me?.isCertificated == true {
                        return .init(isEnabled: false, info: "미션 요일: 월 화 수 목 금 토", title: "오늘 미션 인증 완료!")
                    }
                    if competition.me?.isCertificated == false { // 미션일이고(ex 월) 미션시간전(24시전)이라면
                        return .init(isEnabled: true, info: "오후 미션 인증은 24시까지에요", title: "오늘 미션 인증하기")
                    }
                    if competition.me?.isCertificated == false { // 미션일이 아니거나(ex 월) 미션시간(24시전)이 지났나면
                        return .init(isEnabled: false, info: "오후 미션 인증은 24시까지에요", title: "오늘 미션 인증 시간 마감")
                    }
                    return .init(isEnabled: false, info: "", title: "")
                }()
                
                if competitionState == .disabled {
                    state.destination = .missionDeleteAlert(MissionDeleteAlertFeature.State())
                }
                return .none
            case .didTapMissionInfoButton:
                state.isMissionInfoGuideToolTipShowed = true
                state.path.append(.missionInfo(MissionInfoFeature.State()))
                return .none
            case .didTapSettingButton:
                return .none
            case .didTapPlayer(player: let player):
                guard player.isCertificated,
                        let certification = state.competition?.findCertification(by: player.id) else { return .none }
                state.destination = .imageDetail(ImageDetailFeature.State(player: player, updatedDate: certification.updatedAt, imageURL: certification.imageURL))
                return .none
            case let .didSelectImages(images):
                guard let image = images.first, let me = state.competition?.me else { return .none }
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
                    guard let competition = state.competition, let myPiece = competition.myPiece else { return .none }
                    let newPosition = myPiece.position + 1
                    guard newPosition.index < competition.board.totalBlockCount else {
                        // <경쟁종료됨>
                        // 경쟁종료화면으로 이동
                        return .none
                    }
                    let event = competition.board.findEvent(by: newPosition)
                    state.destination = .certificationResult(CertificationResultFeature.State(event: event))
                    return .none
                case .presented(.certificationResult(.didTapCloseButton)):
                    guard let myPiece = state.competition?.myPiece else { return .none }
                    state.movingPiece = myPiece
                    state.competition?.board.remove(piece: myPiece)
                    return .none
                case .presented(_):
                    return .none
                }
            case let .didFinishMoving(myPiece):
                guard let myPiece else { return .none }
                let newPosition = myPiece.position + 1
                state.competition?.board.update(piece: myPiece, to: newPosition)
                state.competition?.board.update(conqueredPosition: newPosition)
                state.movingPiece = nil
                return .none
            case .path:
                return .none
            case .binding:
                return .none
            case .error:
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
