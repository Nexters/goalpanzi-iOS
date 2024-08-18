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
                do {
                    let endPoint = Endpoint<GetVerificationsResponseDTO>(
                        path: "api/missions/\(missionID)/verifications",
                        httpMethod: .get,
                        queryParameters: GetVerificationsRequestDTO(date: ISO8601DateFormatter.string(from: date, timeZone: .current))
                    )
                    
                    let response = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: authIntercepter)
                    return response.toDomain
                } catch {
                    throw NSError()
                }
            },
            getVerificationsMe: { missionID, number in
                do {
                    let endPoint = Endpoint<GetVerificationsMeResponseDTO>(
                        path: "api/missions/\(missionID)/verifications/me/\(number)",
                        httpMethod: .get
                    )
                    let response = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: authIntercepter)
                    return response.toDomain
                } catch {
                    throw NSError()
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
