//
//  GetSessionDataModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import Foundation

// MARK: - GetSessionDataModel
struct GetSessionDataModel: Codable {
    let sessionID, deviceID: String?
    
    enum CodingKeys: String, CodingKey {
        case sessionID = "session-id"
        case deviceID = "device-id"
    }
}
