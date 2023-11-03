//
//  Configuration.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

enum BaseURLType {
    
    case productionApi
    case staging
    
    var desc : String {
        switch self {
        case .productionApi :
            return NetworkConstants.baseApiUrl
        case .staging :
            return NetworkConstants.stagingApiUrl
        }
    }
}

enum VersionType {
    case none
    case v1
    var desc : String {
        switch self {
        case .none :
            return String()
        case .v1 :
            return NetworkConstants.apiVersion1
        }
    }
}


public class AppConfig {
    
    static let shared = AppConfig()
    
    init() {}
  
    func addDefaultHeaders() -> [String: String] {
        var headers: [String: String] = [:]
        headers[DefaultHeader.contentType.rawValue] = AppSettings.contentType
        headers[DefaultHeader.appVersion.rawValue] = AppSettings.appVersion
        headers[DefaultHeader.platform.rawValue] = AppSettings.platform
        headers[DefaultHeader.authorization.rawValue] = AppSettings.authorization
        headers[DefaultHeader.deviceName.rawValue] = AppSettings.deviceName
        return headers
    }
}


