//
//  LocationItemDataModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation

// MARK: - LocationModel
struct LocationItemDataModel: Codable, Equatable {
    var id: Int?
    var name: String?
    var parentID: Int?
    var type, tzCode, referenceCode: String?
    var cityID, countryID: Int?
    var cityName, countryName, longName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent-id"
        case type, name
        case tzCode = "tz-code"
        case referenceCode = "reference-code"
        case cityID = "city-id"
        case countryID = "country-id"
        case cityName = "city-name"
        case countryName = "country-name"
        case longName = "long-name"
    }
    
    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
    
    public static func == (lhs: LocationItemDataModel, rhs: LocationItemDataModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}


