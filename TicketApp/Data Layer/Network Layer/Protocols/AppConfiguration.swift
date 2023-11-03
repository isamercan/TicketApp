//
//  AppConfiguration.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

// App Configuration Base
protocol AppConfiguration {
    
    var baseURL : BaseURLType { get }
    var version : VersionType { get }
    
}

// App Configuration Set Base
protocol AppConfigurable {
    static var setAppState : AppConfiguration { get }
}



