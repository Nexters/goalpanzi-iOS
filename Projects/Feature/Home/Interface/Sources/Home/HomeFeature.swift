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
        public var isLoading: Bool = false
        
        @Shared(.appStorage("isInvitationGuideToolTipShowed")) var isInvitationGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isMissionInfoGuideToolTipShowed")) var isMissionInfoGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isCertificationImageGuideToolTipShowed")) var isCertificationImageGuideToolTipShowed: Bool = false
        
        @Presents var destination: Destination.State?
        public var path = StackState<Path.State>()
        
        public init() {}
    }
    
    @Reducer
    public enum Destination {
        case missionInvitationInfo(MissionInvitationInfoFeature)
        case missionDeleteAlert(MissionDeleteAlertFeature)
        case certificationResult(CertificationResultFeature)
        case eventResult(MissionResultFeature)
        case imageUpload(ImageUploadFeature)
        case imageDetail(ImageDetailFeature)
        case finish(FinishFeature)
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
        case loading(isLoading: Bool)
        case destination(PresentationAction<Destination.Action>)
        case path(StackActionOf<Path>)
        case binding(BindingAction<State>)
        
        case didFetchMyMissionInfo(MyMissionInfo)
        case didFetchVerificationAndMissionAndBoard(MissionVerification, Mission, MissionBoard)
        case didFetchVerificationInfo(MissionVerification.VerificationInfo)
        case didFetchRank(Int)
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
                        async let verification = try missionVerificationService.getVerifications(missionId, Date.now)
                        let (verificationResult, missionResult, boardResult): (MissionVerification, Mission, MissionBoard) = try await (verification, mission, board)
                        await send(.didFetchVerificationAndMissionAndBoard(verificationResult, missionResult, boardResult))
                    } catch {
                        await send(.error(error))
                    }
                }
            case let .didFetchVerificationAndMissionAndBoard(verification, mission, board):
                state.mission = mission
                
                let players: [Player] = board.missionBoards.flatMap(\.missionBoardMembers).map {
                    Player(id: $0.nickname, pieceID: $0.nickname, name: $0.nickname, character: Character(rawValue: $0.characterType) ?? .rabbit, isMe: state.me?.name == $0.nickname)
                }
                
                let events: [Event] = board.missionBoards.compactMap { (info: MissionBoard.BoardInfo) -> Event? in
                    guard let reward = info.reward else { return nil }
                    return Event.reward(JejuRewardInfo(rawValue: reward, position: Position(index: info.number)))
                }
                
                let theme: JejuIslandBoardTheme = JejuIslandBoardTheme()
                
                let competitionState: Competition.State = {
                    if mission.missionEndDate <= Date.now {
                        return .finished
                    }
                    if mission.missionStartDate <= Date.now, players.count == 1 {
                        return .disabled
                    }
                    if mission.missionStartDate <= Date.now, players.count > 1 {
                        return .started
                    }
                    if mission.missionStartDate > Date.now, players.count == 1 {
                        return .notStarted(hasOtherPlayer: false)
                    }
                    if mission.missionStartDate > Date.now, players.count > 1 {
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
                
                verification.missionVerifications.forEach {
                    competition.certify(playerID: $0.nickname, imageURL: $0.imageUrl, verifiedAt: $0.verifiedAt)
                }
                competition.sortPlayersByVerifiedAt()
                competition.moveMeToFront()
                
                state.competition = competition
                state.certificationButtonState = {
                    if competition.me?.isCertificated == true {
                        let info = "미션 요일: \(mission.missionDays.map { $0.toKorean }.joined(separator: " ") )"
                        return .init(isEnabled: false, info: info, title: "오늘 미션 인증 완료!")
                    }
                    if competition.me?.isCertificated == false {
                        let isMissionTime = mission.checkIsMissionTime
                        let info = "\(mission.timeOfDay.toKorean) 미션 인증은 \(mission.timeOfDay.endTimeString)까지에요"
                        let title = isMissionTime ? "오늘 미션 인증하기" : "오늘 미션 인증 시간 마감"
                        return .init(isEnabled: isMissionTime, info: info, title: title)
                    }
                    return .init(isEnabled: false, info: "", title: "")
                }()
                
                switch competitionState {
                case .disabled:
                    guard let missionId = state.missionId else { return .none }
                    state.destination = .missionDeleteAlert(MissionDeleteAlertFeature.State(missionId: missionId))
                case .finished:
                    return .run { [missionId = state.missionId] send in
                        do {
                            let rankInfo = try await missionMemberService.getMissionMembersRank(missionId ?? 0)
                            await send(.didFetchRank(rankInfo.rank))
                        } catch {
                            await send(.error(error))
                        }
                    }
                default:
                    break
                }
                return .none
            case let .didFetchRank(rank):
                guard let missionId = state.missionId, let me = state.competition?.me else { return .none }
                state.destination = .finish(FinishFeature.State(missionId: missionId, player: me, rank: rank))
                return .none
            case .didTapMissionInfoButton:
                state.isMissionInfoGuideToolTipShowed = true
                guard let missionId = state.missionId,
                      let mission = state.mission,
                      let totalBlockCount = state.competition?.board.totalBlockCount else { return .none }
                let infos: [MissionInfoFeature.Info] = [
                    .init(id: "1", title: "미션", description: mission.description),
                    .init(id: "2", title: "미션 기간", description: mission.missionPeriodDescription),
                    .init(id: "3", title: "인증 요일", description: mission.missionWeekDayDescription),
                    .init(id: "4", title: "인증 시간", description: mission.missionTimeDescription)
                ]
                state.path.append(.missionInfo(MissionInfoFeature.State(missionId: missionId, totalBlockCount: totalBlockCount, infos: infos)))
                return .none
            case .didTapSettingButton:
                // 설정화면으로 이동
                return .none
            case let .didTapPlayer(player):
                guard player.isCertificated, let certification = state.competition?.findCertification(by: player.id) else { return .none }
                state.destination = .imageDetail(ImageDetailFeature.State(player: player, verifiedAt: certification.verifiedAt ?? Date.now, imageURL: certification.imageURL))
                return .none
            case let .didSelectImages(images):
                guard let image = images.first, let me = state.competition?.me, let missionId = state.missionId else { return .none }
                state.destination = .imageUpload(ImageUploadFeature.State(missionId: missionId, player: me, selectedImage: image))
                return .none
            case let .didTapPiece(piece):
                guard piece == state.competition?.myPiece else { return .none }
                return .run { [mission = state.mission] send in
                    do {
                        let verificationInfo = try await missionVerificationService.getVerificationsMe(mission?.missionId ?? 0, piece.position.index)
                        await send(.didFetchVerificationInfo(verificationInfo))
                    } catch {
                        await send(.error(error))
                    }
                }
            case let .didFetchVerificationInfo(info):
                state.destination = .imageDetail(
                    ImageDetailFeature.State(
                        player: Player(id: info.nickname, pieceID: info.nickname, name: info.nickname, character: Character(rawValue: info.characterType) ?? .rabbit),
                        verifiedAt: info.verifiedAt,
                        imageURL: info.imageUrl
                    )
                )
                return .none
            case .didTapInvitationInfoButton:
                state.isInvitationGuideToolTipShowed = true
                guard let mission = state.mission else { return .none }
                state.destination = .missionInvitationInfo(MissionInvitationInfoFeature.State(invitationCode: mission.invitationCode))
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
                    guard newPosition.index < competition.board.totalBlockCount else { return .none }
                    let event = competition.board.findEvent(by: newPosition)
                    state.destination = .certificationResult(CertificationResultFeature.State(event: event))
                    return .none
                case .presented(.certificationResult(.didTapCloseButton)):
                    guard let myPiece = state.competition?.myPiece else { return .none }
                    state.movingPiece = myPiece
                    state.competition?.board.remove(piece: myPiece)
                    return .none
                case .presented(.finish(.didTapConfirmButton)):
                    // 경쟁시작화면으로 이동
                    return .none
                case .presented(.finish(.didTapSettingButton)):
                    //설정화면으로 이동
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
            case let .error(error):
                return .none
            case let .loading(isLoading):
                state.isLoading = isLoading
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
