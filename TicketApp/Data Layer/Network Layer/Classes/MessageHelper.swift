//
//  MessageHelper.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//


import Foundation

struct MessageHelper {
    
    /// General Message Handler
    struct serverError {
        static let general : String = "Bad Request"
        static let noInternet : String = "Check the Connection"
        static let timeOut : String = "Timeout"
        static let notFound : String = "No Result"
        static let serverError : String = "Internal Server Error"
        static let noData : String = "Not Data Found"
        static let authFailed: String = "Auth Failed"
    }
}

