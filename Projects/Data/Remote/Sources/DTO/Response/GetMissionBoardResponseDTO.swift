//
//  GetMissionBoardResponseDTO.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation

struct GetMissionBoardResponseDTO: Decodable {
    
    struct Board: Decodable {
        let number: Int
        let reward: String
        let missionBoardMembers: [Member]
    }
    
    struct Member: Decodable {
        let nickname: String
        let characterType: String
    }
    
    let missionBoards: [Board]
}
