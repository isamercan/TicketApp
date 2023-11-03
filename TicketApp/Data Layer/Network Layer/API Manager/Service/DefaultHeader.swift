//
//  DefaultHeader.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

public enum DefaultHeader: String {
    case contentType    = "Content-Type"
    case appVersion     = "App-Version" //"x-device-app-ver"
    case authorization  = "Authorization"
    case platform       = "platform"
    case deviceToken    = "Device-Token"
    case deviceName     = "Device-Name"
    case deviceType     = "Device-Type"
}
