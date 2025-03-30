//
//  RegisterDeviceTokenRequestDTO.swift
//  DataRemote
//
//  Created by Miro on 3/30/25.
//

import Foundation

struct RegisterDeviceTokenRequestDTO: Encodable {

    let deviceToken: String
    let deviceIdentifier: String
    let osType: String

    init(deviceToken: String, deviceIdentifier: String, osType: String = "IOS") {
        self.deviceToken = deviceToken
        self.deviceIdentifier = deviceIdentifier
        self.osType = osType
    }
}
