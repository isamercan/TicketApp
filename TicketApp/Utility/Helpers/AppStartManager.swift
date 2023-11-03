//
//  AppStartManager.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation

////This class appears to manage the initialization and retrieval of application sessions.
/// which means it cannot be subclassed. This class is designed to handle the startup logic of an application.
final class AppStartManager {
    
    static var shared = AppStartManager(dataProvider: GeneralDataProvider(), sessionLocalDataProvider: SessionLocalDataProvider())
    
    private let dataProvider: GeneralDataProviderProtocol
    private let sessionLocalDataProvider: SessionLocalDataProviderProtocol
    private let logger: ErrorLoggable?
    
//    This is the designated initializer of the AppStartManager class. It initializes the class with custom data providers for both network-based session retrieval and local session management.
    init(dataProvider: GeneralDataProviderProtocol, sessionLocalDataProvider: SessionLocalDataProviderProtocol) {
        self.dataProvider = dataProvider
        self.sessionLocalDataProvider = sessionLocalDataProvider
        self.logger = Logger()
    }
    
    //This method is named getSessionRequestModel, and its primary purpose is to create and return an instance of a SessionRequestModel.
    private func getSessionRequestModel() -> SessionRequestModel {
        let type = NetworkConstants.deviceTyoe
        let connection = Connection(ipAddress: IPAddressManager.shared.getIPAddress())
        let request = SessionRequestModel(type: type, connection: connection, application: Application())
        return request
    }
    
//    This method is responsible for fetching and managing application sessions.
//    Inside the method, it calls dataProvider.getSession to fetch a session, and then it processes the result.
//    If the session retrieval is successful, it sets the session data using sessionLocalDataProvider.
//    If there's an error during the session retrieval, it logs the error using the logger (if available).

//    In summary, the AppStartManager class is responsible for initializing and managing the application's startup logic, including the retrieval and storage of sessions. It also provides a shared instance that can be used globally to access its functionality. Additionally, it logs errors when necessary and has a pending task to remove existing sessions as indicated by the TODO comment.
    
    func getSession() {
        let request = getSessionRequestModel()
        dataProvider.getSession(model: request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                guard let data = response.data else { return }
                let _ = self.sessionLocalDataProvider.setSession(data)
            case .failure(let error):
                self.logger?.log(error, with: ["info": "Function: \(#function), line: \(#line)"])
            }
        }
    }
    
}
