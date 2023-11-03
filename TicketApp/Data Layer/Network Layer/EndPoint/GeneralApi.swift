//
//  GeneralApi.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import Foundation
import Alamofire

enum GeneralApi {
    case getsession(model: SessionRequestModel)
}

extension GeneralApi: TargetType {
    var path: RequestType {
        switch self {
        case .getsession:
            return .requestPath(path: "client/getsession")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getsession:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getsession(let model):
            return .requestParameters(parameters: model.dictionary, encoding: JSONEncoding.default)
        }
    }
    
    var baseURL: BaseURLType {
        switch self {
        case .getsession:
            return .productionApi
        }
    }
}
