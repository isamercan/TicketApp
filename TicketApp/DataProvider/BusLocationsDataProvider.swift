//
//  DashboardDataProvider.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import Foundation

typealias BusLocationsResult = (Result<BaseResponse<[LocationItemDataModel]>, APIError>) -> Void

protocol BusLocationsDataProviderProtocol {
    func getBusLocations(model: BaseRequestModel<String>, completion: @escaping BusLocationsResult)
}

class BusLocationsDataProvider: BaseAPI<DashboardApi>, BusLocationsDataProviderProtocol {
    func getBusLocations(model: BaseRequestModel<String>, completion: @escaping BusLocationsResult) {
        fetchData(target: .getBusLocations(model: model)) { result in
            completion(result)
        }
    }
}
