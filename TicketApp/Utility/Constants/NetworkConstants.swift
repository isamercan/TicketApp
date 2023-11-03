//
//  NetworkConstants.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

struct NetworkConstants {
    static let baseApiUrl = "https://v2-api.obilet.com/api/"
    static let stagingApiUrl = "https://v2-api.obilet.com/api/"
    static let s3Url = "https://s3.eu-central-1.amazonaws.com/static.obilet.com/images/feature/{{feature-id}}.svg"
    static let apiVersion1 = "/v1"    
    static let urlFixer = "?raw=true"
    static let deviceTyoe = 2
    static let locale =  "tr-TR"
}




struct RegexConstants {
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}

