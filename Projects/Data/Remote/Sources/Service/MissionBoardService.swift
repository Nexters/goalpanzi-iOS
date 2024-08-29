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
                    httpMethod: .get
                )
                
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: AuthInterceptor())
                
                switch response {
                case .success(let response):
                    return response.toDomain
                case .failure(let error):
                    throw error
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
            },
            progressCount: progressCount
        )
    }
}
