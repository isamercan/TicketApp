//
//  DashboardDataProvider.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import Foundation

// Alias for the result of a bus locations request
typealias BusLocationsResult = (Result<BaseResponse<[LocationItemDataModel]>, APIError>) -> Void

// Protocol for the bus locations data provider
protocol BusLocationsDataProviderProtocol {
    func getBusLocations(model: BaseRequestModel<String>, completion: @escaping BusLocationsResult)
}

// Implementation of the bus locations data provider
class BusLocationsDataProvider: BaseAPI<DashboardApi>, BusLocationsDataProviderProtocol {
    // Fetch bus locations data with a request and completion handler
    func getBusLocations(model: BaseRequestModel<String>, completion: @escaping BusLocationsResult) {
        fetchData(target: .getBusLocations(model: model)) { result in
            completion(result)
        }
    }
}
