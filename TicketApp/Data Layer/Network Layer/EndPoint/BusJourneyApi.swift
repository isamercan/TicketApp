//
//  BusJourneyApi.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import Foundation
import Alamofire

enum BusJourneyApi {
    case getbusjourneys(request: BaseRequestModel<GetBusJourneyRequestDataModel>)
}

extension BusJourneyApi: TargetType {
    var path: RequestType {
        switch self {
        case .getbusjourneys:
            return .requestPath(path: "journey/getbusjourneys")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getbusjourneys:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getbusjourneys(let request):
            return .requestParameters(parameters: request.dictionary, encoding: JSONEncoding.default)
        }
    }
    
    var baseURL: BaseURLType {
        switch self {
        case .getbusjourneys:
            return .productionApi
        }
    }
}
