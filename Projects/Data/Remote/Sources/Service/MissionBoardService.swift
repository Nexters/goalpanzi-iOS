//
//  MissionBoardServcie.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import DomainBoardInterface
import CoreNetworkInterface
import DataRemoteInterface
import ComposableArchitecture
import Alamofire

extension MissionBoardService: DependencyKey {
    
    public static let liveValue: MissionBoardService = {
        return Self(
            getBoard: { missionID in

                let endPoint = Endpoint<GetMissionBoardResponseDTO>(
                    path: "api/missions/\(missionID)/board",
                    httpMethod: .get,
                    queryParameters: EmptyRequest()
                )
                
                do {
                    let response = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: AuthInterceptor())
                    return response.toDomain
                } catch {
                    throw NSError()
                }
            }
        )
    }()
}

extension GetMissionBoardResponseDTO {
    
    var toDomain: MissionBoard {
        MissionBoard(
            missionBoards: missionBoards.map {
                MissionBoard.BoardInfo(
                    number: $0.number,
                    reward: $0.reward,
                    missionBoardMembers: $0.missionBoardMembers.map {
                        .init(nickname: $0.nickname, characterType: $0.characterType)
                    }
                )
            }
        )
    }
}
