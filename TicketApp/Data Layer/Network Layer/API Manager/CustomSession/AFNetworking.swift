//
//  AFNetworking.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation
import Alamofire

final class AFNetworking {

    let session: Session
    
    /// - Parameter allHostsMustBeEvaluated: it configures certificate pinning behaviour
    /// if true: Alamofire will only allow communication with hosts defined in evaluators and matching defined Certificates.
    /// if false: Alamofire will check certificates only for hosts defined in evaluators dictionary. Communication with other hosts than defined will not use Certificate pinning
    required init(allHostsMustBeEvaluated: Bool) {
        session = Session(eventMonitors: [AlamofireLogger()])
    }
}
