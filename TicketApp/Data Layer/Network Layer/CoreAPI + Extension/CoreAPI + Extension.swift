//
//  CoreApı.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation
import Alamofire

extension BaseAPI {

    // Build parameters and parameter encoding for a network request task
    func buildParameters(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    // Build the target for a network request based on the RequestType
    func buildTarget(target : RequestType) -> String {
        switch target {
        case .requestPath(path: let path):
            return path
        case .queryParametrs(query: let query):
            return query
        }
    }
    
    // Build headers for a network request
    func buildHeaders(target: RequestType) -> [String:Any] {
        return [:]
    }
}
