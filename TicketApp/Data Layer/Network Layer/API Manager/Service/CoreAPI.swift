//
//  CoreAPI.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//
import UIKit
import Alamofire

class BaseAPI<T: TargetType> {
    
    private let networking : AFNetworking
    
    /// - Returns: `etc completion(.failure(.timeout)) || completion(.success(value))`.
    init(networking : AFNetworking = AFNetworking(allHostsMustBeEvaluated: false)) {
        self.networking = networking
    }
    
    func fetchData<M: Decodable>(target: T, completion:@escaping (Result<M, APIError>)->Void) {        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let allHeader = target.headers + AppConfig.shared.addDefaultHeaders()
        let headers = Alamofire.HTTPHeaders(allHeader)
        let params = buildParameters(task: target.task)
        let targetPath = buildTarget(target: target.path)
        let url = (target.baseURL.desc + target.version.desc + targetPath)
        
        networking.session.request(url, method: method, parameters: params.0, encoding: params.1, headers: headers, requestModifier: { $0.timeoutInterval = 20 })
            .validate()
            .responseDecodable(of: M.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    guard response.response?.statusCode != 401 && !error.isAuthFailed else {
                       return completion(.failure(.expiredToken(message: error.localizedDescription + " \(MessageHelper.serverError.authFailed)")))}
                    guard !error.isTimeout else {return completion(.failure(.timeout)) }
                    guard !error.isConnectedToTheInternet else { return completion(.failure(.noNetwork)) }
                    return completion(.failure(.statusMessage(message: error.localizedDescription)))
                }
            }
    }
}
