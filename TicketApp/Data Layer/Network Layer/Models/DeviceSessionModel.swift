//
//  DeviceSessionModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import Foundation

// MARK: - DeviceSessionModel
struct DeviceSessionModel: Codable, Hashable {
    let sessionID, deviceID: String?

    enum CodingKeys: String, CodingKey {
        case sessionID = "session-id"
        case deviceID = "device-id"
    }
    
    static func == (lhs: DeviceSessionModel, rhs: DeviceSessionModel) -> Bool {
        return lhs.sessionID == rhs.sessionID
    }
}
