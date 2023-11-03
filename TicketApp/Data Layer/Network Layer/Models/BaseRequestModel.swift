//
//  BaseRequestModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import Foundation
// MARK: - BaseRequestModel

struct BaseRequestModel<T: Codable>: Codable {
    let deviceSession: DeviceSessionModel?
    let date: String
    let language: String = NetworkConstants.locale
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case deviceSession = "device-session"
        case date, language, data
    }
}
