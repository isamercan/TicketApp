//
//  SessionRequestModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation

// MARK: - SessionRequestModel
struct SessionRequestModel: Codable {
    let type: Int?
    let connection: Connection?
    let application: Application?
}

// MARK: - Application
struct Application: Codable {
    let version: String? = "1.0.0.0"
    let equipmentID: String? = "distribusion"
    
    enum CodingKeys: String, CodingKey {
        case version
        case equipmentID = "equipment-id"
    }
}

// MARK: - Connection
struct Connection: Codable {
    let ipAddress: String?

    enum CodingKeys: String, CodingKey {
        case ipAddress = "ip-address"
    }
}
