//
//  DashboardApi.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import Foundation
import Alamofire

enum DashboardApi {
    case getBusLocations(model: BaseRequestModel<String>)
}

extension DashboardApi: TargetType {
    var path: RequestType {
        switch self {
        case .getBusLocations:
            return .requestPath(path: "location/getbuslocations")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getBusLocations:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getBusLocations(let model):
            return .requestParameters(parameters: model.dictionary, encoding: JSONEncoding.default)
        }
    }
    
    var baseURL: BaseURLType {
        switch self {
        case .getBusLocations:
            return .productionApi
        }
    }
}
