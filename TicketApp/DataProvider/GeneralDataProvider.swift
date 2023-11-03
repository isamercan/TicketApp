//
//  GeneralDataProvider.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import Foundation

typealias GetSessionResult = (Result<BaseResponse<DeviceSessionModel>, APIError>) -> Void

protocol GeneralDataProviderProtocol {
    func getSession(model: SessionRequestModel, completion: @escaping GetSessionResult)
}

class GeneralDataProvider: BaseAPI<GeneralApi>, GeneralDataProviderProtocol {
    func getSession(model: SessionRequestModel, completion: @escaping GetSessionResult) {
        fetchData(target: .getsession(model: model)) { result in
            completion(result)
        }
    }
}
