//
//  AFError + Extension.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation
import Alamofire

extension AFError {
    
    var isTimeout: Bool {
        if isSessionTaskError,
           let error = underlyingError as NSError?,
           error.code == NSURLErrorTimedOut || error.code == NSURLErrorUnknown {
            return true
        }
        return false
    }
    
    var isConnectedToTheInternet: Bool {
        if isSessionTaskError,
           let error = underlyingError as NSError?,
           error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorDataNotAllowed {
            return true
        }
        return false
    }
    
    var isAuthFailed: Bool {
        
        if self.responseCode == NSURLErrorUserAuthenticationRequired ||
            self.responseCode == NSURLErrorUserCancelledAuthentication {
            return true
        }
        return false
    }
}
