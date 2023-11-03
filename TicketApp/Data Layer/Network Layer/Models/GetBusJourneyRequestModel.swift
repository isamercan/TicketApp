//
//  GetBusJourneyRequestModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import Foundation

// MARK: - GetBusJourneyRequestModel
struct GetBusJourneyRequestDataModel: Codable {
    let originID, destinationID: Int?
    let departureDate: String?

    enum CodingKeys: String, CodingKey {
        case originID = "origin-id"
        case destinationID = "destination-id"
        case departureDate = "departure-date"
    }
}
