//
//  GeneralDataProvider.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import Foundation

// Alias for the result of a session request
typealias GetSessionResult = (Result<BaseResponse<DeviceSessionModel>, APIError>) -> Void

// Protocol for the general data provider
protocol GeneralDataProviderProtocol {
    func getSession(model: SessionRequestModel, completion: @escaping GetSessionResult)
}

// Implementation of the general data provider
class GeneralDataProvider: BaseAPI<GeneralApi>, GeneralDataProviderProtocol {
    // Fetch a session with a request and completion handler
    func getSession(model: SessionRequestModel, completion: @escaping GetSessionResult) {
        fetchData(target: .getsession(model: model)) { result in
            completion(result)
        }
    }
}
