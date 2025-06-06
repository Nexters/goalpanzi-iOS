//
//  HistoryService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 6/1/25.
//

import Foundation
import DomainHistoryInterface
import DomainUserInterface
import CoreNetworkInterface
import DataRemoteInterface
import ComposableArchitecture
import Alamofire

extension MissionHistoryService: DependencyKey {
    
    public static let liveValue: MissionHistoryService = {
        return Self(
            getMissionsHistoriesMe: { page, pageSize in
                let endPoint = Endpoint<GetMissionHistoriesMeResponseDTO>(path: "api/missions/histories/me", httpMethod: .get)
                let response = await NetworkProvider.shared
                    .sendRequest(endPoint, interceptor: AuthInterceptor())
                
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

extension GetMissionHistoriesMeResponseDTO {
    
    var toDomain: MissionHistoryInfo {
        MissionHistoryInfo(
            totalCount: totalCount,
            hasNext: hasNext,
            resultList: resultList.map(
                {
                    .init(
                        missionId: $0.missionId,
                        description: $0.description,
                        missionStartDate: $0.missionStartDate,
                        missionEndDate: $0.missionEndDate,
                        myVerificationCount: $0.myVerificationCount,
                        totalVerificationCount: $0.totalVerificationCount,
                        rank: $0.rank,
                        randomImageUrlList: $0.randomImageUrlList.compactMap {
                            URL(string: $0)
                        },
                        memberCount: $0.memberCount,
                        missionMembers: $0.missionMembers.map(
                            {
                                .init(
                                    memberId: $0.memberId,
                                    nickname: $0.nickname,
                                    character: Character(rawValue: $0.characterType) ?? .rabbit
                                )
                            }
                        )
                    )
            })
        )
    }
}
