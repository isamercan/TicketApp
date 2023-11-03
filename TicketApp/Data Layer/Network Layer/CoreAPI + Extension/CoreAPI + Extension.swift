//
//  CoreApı.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation
import Alamofire

extension BaseAPI {

    func buildParameters(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    func buildTarget(target : RequestType) -> String {
        switch target {
        case .requestPath(path: let path):
            return path
        case .queryParametrs(query: let query):
            return query
        }
    }
    
    func buildHeaders(target: RequestType) -> [String:Any] {
        return [:]
    }
}
