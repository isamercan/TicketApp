//
//  SearchDataModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation
// MARK: - SearchDataModel

// A struct representing search data for bus journeys
struct SearchDataModel: Codable {
    // Departure location for the bus journey
    var departureLocation: LocationItemDataModel?
    
    // Arrival location for the bus journey
    var arriveLocation: LocationItemDataModel?
    
    // Departure date for the bus journey
    var departureDate: Date?
}
