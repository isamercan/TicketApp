//
//  APIError.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

enum APIError : Error {
    case general
    case timeout
    case pageNotFound
    case noData
    case noNetwork
    case unknownError
    case serverError
    case statusMessage(message : String)
    case decodeError(String)
    case expiredToken(message: String)
    
    var isTokenError: Bool {
        switch self {
        case .expiredToken:
            return true
        default:
            return false
        }
    }
}

extension APIError {
    
    ///Title of error
    var title: String {
        switch self {
        case .general:                              return MessageHelper.serverError.general
        case .timeout:                              return MessageHelper.serverError.timeOut
        case .pageNotFound:                         return MessageHelper.serverError.notFound
        case .noData:                               return MessageHelper.serverError.notFound
        case .noNetwork:                            return MessageHelper.serverError.noInternet
        case .unknownError:                         return MessageHelper.serverError.general
        case .serverError:                          return MessageHelper.serverError.serverError
        case .statusMessage(let message):           return message
        case .decodeError(let error):               return error
        case .expiredToken(let message):            return message
        }
    }
    
    ///Description of error
    var desc: String {
        
        switch self {
        case .general:                          return MessageHelper.serverError.general
        case .timeout:                          return MessageHelper.serverError.timeOut
        case .pageNotFound:                     return MessageHelper.serverError.notFound
        case .noData:                           return MessageHelper.serverError.noData
        case .noNetwork:                        return MessageHelper.serverError.noInternet
        case .unknownError:                     return MessageHelper.serverError.general
        case .serverError:                      return MessageHelper.serverError.serverError
        case .statusMessage(let message):       return message
        case .decodeError(let error):           return error
        case .expiredToken(let message):        return message
        }
    }
}
