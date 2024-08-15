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
        public var missionId: Int? = nil
        public var mission: Mission? = nil
        public var me: Player? = nil
        public var competition: Competition? = nil
        public var movingPiece: Piece? = nil
        public var selectedImages: [UIImage] = []
        public var ctaButtonState: CTAButtonState = .default
        public var isLoading: Bool = false
        
        @Shared(.appStorage("isInvitationGuideToolTipShowed")) var isInvitationGuideToolTipShowed: Bool = false
        @Shared(.appStorage("isMissionInfoGuideToolTipShowed")) var isMissionInfoGuideToolTipShowed: Bool = false
        
        @Presents var destination: Destination.State?
        public var path = StackState<Path.State>()
        
        public init() {}
    }
    
    @Reducer
    public enum Destination {
        case missionInvitationInfo(InvitationInfoFeature)
        case missionDeleteAlert(MissionDeleteAlertFeature)
        case certificationResult(VerificationResultFeature)
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
        case loadData(missionId: Int)
        case didLoadData(Competition.State)
        case destination(PresentationAction<Destination.Action>)
        case path(StackActionOf<Path>)
        case binding(BindingAction<State>)
        
        case didFetchMyMissionInfo(Result<MyMissionInfo, Error>)
        case didFetchVerificationAndMissionAndBoard(Result<(MissionVerification, Mission, MissionBoard), Error>)
        case didFetchVerificationInfo(Result<MissionVerification.VerificationInfo, Error>)
        case didFetchRank(Result<MissionRank, Error>)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    await send(.didFetchMyMissionInfo( Result { try await missionMemberService.getMissionMembersMe() } ))
                }
                
            case let .didFetchMyMissionInfo(.success(myMissionInfo)):
                state.isLoading = false
                state.me = Player(
                    id: myMissionInfo.profile.nickname,
                    pieceID: myMissionInfo.profile.nickname,
                    name: myMissionInfo.profile.nickname,
                    character: DomainUserInterface.Character(rawValue: myMissionInfo.profile.characterType) ?? .rabbit
                )
                state.missionId = myMissionInfo.missions.first?.missionId
                return .send(.loadData(missionId: state.missionId ?? 0))
                
            case let .loadData(missionId):
                return .run { send in
                    await send(.didFetchVerificationAndMissionAndBoard(
                        Result {
                            async let mission = try missionService.getMissions(missionId)
                            async let board = try missionBoardService.getBoard(missionId)
                            async let verification = try missionVerificationService.getVerifications(missionId, Date.now)
                            return try await (verification, mission, board)
                        }
                    ))
                }
            
            case let .didFetchVerificationAndMissionAndBoard(.success((verification, mission, board))):
                state.isLoading = false
                state.mission = mission
                let players: [Player] = board.missionBoards.flatMap(\.missionBoardMembers).map {
                    Player(
                        id: $0.nickname,
                        pieceID: $0.nickname,
                        name: $0.nickname,
                        character: Character(rawValue: $0.characterType) ?? .rabbit,
                        isMe: state.me?.name == $0.nickname
                    )
                }
                let competitionState = mission.competitionState(hasOtherPlayers: players.count > 1)
                var competition = Competition(
                    players: players,
                    board: Board(
                        theme: JejuIslandBoardTheme(),
                        events: board.missionBoards.map {
                            Event.reward(JejuRewardInfo(rawValue: $0.reward, position: Position(index: $0.number)))
                        },
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
                    competition.verify(playerID: $0.nickname, imageURL: $0.imageUrl, verifiedAt: $0.verifiedAt)
                }
                competition.sortPlayersByVerifiedAt()
                competition.moveMeToFront()
                
                state.competition = competition
                state.ctaButtonState = makeCTAButtonState(isMeCertificated: state.competition?.me?.isCertificated == true, mission: mission)
                return .send(.didLoadData(competitionState))
                
            case let .didLoadData(competitionState):
                switch competitionState {
                case .disabled:
                    state.destination = .missionDeleteAlert(MissionDeleteAlertFeature.State(missionId: state.missionId ?? 0))
                    return .none
                    
                case .finished:
                    state.isLoading = true
                    return .run { [missionId = state.missionId] send in
                        await send(.didFetchRank( Result { try await missionMemberService.getMissionMembersRank(missionId ?? 0) } ))
                    }
                    
                default:
                    return .none
                }
                
            case let .didFetchRank(.success(rankInfo)):
                state.isLoading = false
                guard let missionId = state.missionId, let me = state.me else { return .none }
                state.destination = .finish(FinishFeature.State(missionId: missionId, player: me, rank: rankInfo.rank))
                return .none
            
            case .didTapMissionInfoButton:
                state.isMissionInfoGuideToolTipShowed = true
                guard let missionId = state.missionId,
                      let mission = state.mission,
                      let totalBlockCount = state.competition?.board.totalBlockCount else { return .none }
                state.path.append(.missionInfo(MissionInfoFeature.State(missionId: missionId, totalBlockCount: totalBlockCount, infos: mission.toInfos)))
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
                state.isLoading = true
                return .run { [mission = state.mission] send in
                    await send(.didFetchVerificationInfo(
                        Result { try await missionVerificationService.getVerificationsMe(mission?.missionId ?? 0, piece.position.index) }
                    ))
                }
                
            case let .didFetchVerificationInfo(.success(info)):
                state.isLoading = false
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
                state.destination = .missionInvitationInfo(InvitationInfoFeature.State(invitationCode: mission.invitationCode))
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
                case .presented(.imageUpload(.didNotifyImageUploadFinished)):
                    guard let competition = state.competition, let myPiece = competition.myPiece else { return .none }
                    let newPosition = myPiece.position + 1
                    guard newPosition.index < competition.board.totalBlockCount else { return .none }
                    let event = competition.board.findEvent(by: newPosition)
                    state.destination = .certificationResult(VerificationResultFeature.State(event: event))
                    return .none
                    
                case .presented(.certificationResult(.didTapCloseButton)):
                    guard let myPiece = state.competition?.myPiece else { return .none }
                    state.movingPiece = myPiece
                    state.competition?.board.remove(piece: myPiece)
                    return .send(.loadData(missionId: state.missionId ?? 0))
                    
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
                
            case .didFetchMyMissionInfo(.failure):
                state.isLoading = false
                return .none
                
            case .didFetchVerificationAndMissionAndBoard(.failure):
                state.isLoading = false
                return .none
                
            case .didFetchRank(.failure):
                state.isLoading = false
                return .none
                
            case .didFetchVerificationInfo(.failure):
                state.isLoading = false
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
        .forEach(\.path, action: \.path)
    }
    
    public init() {}
}

public extension HomeFeature {
    
    struct CTAButtonState {
        static let `default`: Self = .init(isEnabled: false, info: "", title: "")
        let isEnabled: Bool
        let info: String
        let title: String
    }
    
    func makeCTAButtonState(isMeCertificated: Bool, mission: Mission) -> CTAButtonState {
        switch isMeCertificated {
        case true:
            return .init(
                isEnabled: false,
                info: "미션 요일: \(mission.missionDays.map { $0.toKorean }.joined(separator: " "))",
                title: "오늘 미션 인증 완료!"
            )
        case false:
            return .init(
                isEnabled: mission.checkIsMissionTime,
                info: "\(mission.timeOfDay.toKorean) 미션 인증은 \(mission.timeOfDay.endTime)시까지에요",
                title: mission.checkIsMissionTime ? "오늘 미션 인증하기" : "오늘 미션 인증 시간 마감"
            )
        }
    }
}