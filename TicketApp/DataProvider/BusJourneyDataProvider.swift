//
//  BusJourneyDataProvider.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import Foundation

typealias BusJourneyResult = (Result<BaseResponse<[JourneyItemDataModel]>, APIError>) -> Void

protocol BusJourneyDataProviderProtocol {
    func getBusJourneys(request: BaseRequestModel<GetBusJourneyRequestDataModel>, completion: @escaping BusJourneyResult)
}

class BusJourneyDataProvider: BaseAPI<BusJourneyApi>, BusJourneyDataProviderProtocol {
    func getBusJourneys(request: BaseRequestModel<GetBusJourneyRequestDataModel>, completion: @escaping BusJourneyResult) {
        fetchData(target: .getbusjourneys(request: request)) { result in
            completion(result)
        }
    }
}
