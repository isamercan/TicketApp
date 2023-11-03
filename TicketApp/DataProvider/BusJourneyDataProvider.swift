//
//  BusJourneyDataProvider.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import Foundation

// Alias for the result of a bus journey request
typealias BusJourneyResult = (Result<BaseResponse<[JourneyItemDataModel]>, APIError>) -> Void

// Protocol for the bus journey data provider
protocol BusJourneyDataProviderProtocol {
    func getBusJourneys(request: BaseRequestModel<GetBusJourneyRequestDataModel>, completion: @escaping BusJourneyResult)
}

// Implementation of the bus journey data provider
class BusJourneyDataProvider: BaseAPI<BusJourneyApi>, BusJourneyDataProviderProtocol {
    // Fetch bus journey data with a request and completion handler
    func getBusJourneys(request: BaseRequestModel<GetBusJourneyRequestDataModel>, completion: @escaping BusJourneyResult) {
        fetchData(target: .getbusjourneys(request: request)) { result in
            completion(result)
        }
    }
}
