//
//  MissionVerificationService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import SharedUtilInterface
import DomainCompetitionInterface
import CoreNetworkInterface
import DataRemoteInterface
import ComposableArchitecture
import Alamofire

extension MissionVerificationService: DependencyKey {
    
    public static let liveValue: MissionVerificationService = {
        
        let authIntercepter = AuthInterceptor()
        
        return Self(
            postVerificationsMe: { missionID, imageJPEGData in
                do {
                    let result = try await NetworkProvider.shared.upload(url: "api/missions/\(missionID)/verifications/me", imageJPEGData: imageJPEGData, interceptor: authIntercepter)
                    return
                } catch {
                    throw NSError()
                }
            },
            getVerifications: { missionID, date in
                let endPoint = Endpoint<GetVerificationsResponseDTO>(
                    path: "api/missions/\(missionID)/verifications",
                    httpMethod: .get,
                    queryParameters: GetVerificationsRequestDTO(date: ISO8601DateFormatter.string(from: date, timeZone: .current))
                )
                
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: authIntercepter)
                
                switch response {
                case .success(let response):
                    return response.toDomain
                case .failure(let error):
                    throw error
                }
            },
            getVerificationsMe: { missionID, number in
                let endPoint = Endpoint<GetVerificationsMeResponseDTO>(
                    path: "api/missions/\(missionID)/verifications/me/\(number)",
                    httpMethod: .get
                )
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: authIntercepter)
                
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

extension GetVerificationsResponseDTO {
    
    var toDomain: MissionVerification {
        MissionVerification(
            missionVerifications: missionVerifications.map {
                MissionVerification.VerificationInfo(
                    nickname: $0.nickname,
                    characterType: $0.characterType,
                    imageUrl: $0.imageUrl,
                    verifiedAt: $0.verifiedAt
                )
            }
        )
    }
}

extension GetVerificationsMeResponseDTO {
    
    var toDomain: MissionVerification.VerificationInfo {
        MissionVerification.VerificationInfo(
            nickname: nickname,
            characterType: characterType,
            imageUrl: imageUrl,
            verifiedAt: verifiedAt
        )
    }
}
