//
//  BuildConfig.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//


import Foundation

struct BuildConfig : AppConfigurable {
    
    static var setAppState: AppConfiguration {
        // return help you to change thec AppConfigState
        return Realese()
    }
}

private struct Realese : AppConfiguration {
    var baseURL : BaseURLType = .productionApi
    var version : VersionType = .none
}

private struct Staging : AppConfiguration {
    
    var baseURL : BaseURLType = .staging
    var version : VersionType = .none
    
    func isVPNConnected() -> Bool {
        return false
    }
    
    func isJailBrokenDevice() -> Bool {
        return false
    }
    
    func enableCertificatePinning() -> Bool {
        return false
    }
}
