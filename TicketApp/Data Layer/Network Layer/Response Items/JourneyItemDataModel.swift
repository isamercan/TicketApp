//
//  GetJourneyDataModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

// MARK: - JourneyItemDataModel
struct JourneyItemDataModel: Codable {
    let id: Int?
    let partnerID: Int?
    let journey: Journey?
    let originLocation: String?
    let destinationLocation: String?
    let originLocationID, destinationLocationID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case partnerID = "partner-id"
        case journey
        case originLocation = "origin-location"
        case destinationLocation = "destination-location"
        case originLocationID = "origin-location-id"
        case destinationLocationID = "destination-location-id"
    }
    
    //Value Mutating
    var departureTime: String { DateTimeManager.shared().format(.hourAndMinute, date: journey?.departure ?? String())}
    var arrivalTime: String { DateTimeManager.shared().format(.hourAndMinute, date: journey?.arrival ?? String())}
    var fullDestination: String { (originLocation ?? String()) + String(" - ") + (destinationLocation ?? String()) }
    var amountStr: String { (journey?.originalPrice?.localizedPrice ?? String()) + String(" ") + (journey?.currency ?? String("TRY")) }
}

// MARK: - Journey
struct Journey: Codable {
    let origin: String?
    let destination: String?
    let departure, arrival, currency: String?
    let originalPrice, internetPrice: Double?
    let providerInternetPrice: Double?
    
    enum CodingKeys: String, CodingKey {
        case origin
        case destination, departure, arrival, currency
        case originalPrice = "original-price"
        case internetPrice = "internet-price"
        case providerInternetPrice = "provider-internet-price"
    }
}
