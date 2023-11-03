//
//  SearchDataModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation

// MARK: - SearchDataModel
struct SearchDataModel: Codable {
    var departureLocation: LocationItemDataModel?
    var arriveLocation: LocationItemDataModel?
    var departureDate: Date?
}
