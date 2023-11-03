//
//  SessionLocalDataProvider.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import Foundation
import CoreData

protocol SessionLocalDataProviderProtocol {
    func getSession() -> DeviceSessionModel?
    func setSession(_ model: DeviceSessionModel) -> Result<Bool, Error>
    func removeSessions(with sessionID: String)
}

final class SessionLocalDataProvider: SessionLocalDataProviderProtocol {
    private let repository: CoreDataRepository<SessionEntity>
    private let logger: ErrorLoggable?
    
    /**
     - Parameters:
     - logger: The `ErrorLoggable` logger to be used to log errors.
     */
    
    public init(logger: ErrorLoggable? = Logger()) {
        self.repository = CoreDataRepository<SessionEntity>()
        self.logger = logger
    }
    
    public func getSession() -> DeviceSessionModel? {
        let predicate = NSPredicate(format: "id == '0'")
        let req: NSFetchRequest<SessionEntity> = SessionEntity.fetchRequest()
        req.fetchLimit = 200
        let result = repository.get(predicate: predicate, sortDescriptors: nil)
            switch result {
            case .success(let managedObject):
                if !managedObject.isEmpty {
                    let last = managedObject[0]
                    let session = DeviceSessionModel(sessionID: last.sessionID, deviceID: last.deviceID )
                    return session
                }
                return nil
            case .failure(let error):
                return nil
                self.logger?.log(error, with: ["info": "Function: \(#function), line: \(#line)"])
            }
    }
    
    /**
     Adds the given session to Local Data.
     - Parameters:
     - model: The model to be added. It can be session from user device
     */
    public func setSession(_ model: DeviceSessionModel) -> Result<Bool, Error> {
        removeAllSessions()
        let result = repository.create()
        switch result {
        case .success(let entity):
            entity.id = "0"
            entity.sessionID = model.sessionID ?? String()
            entity.deviceID = model.deviceID ?? String()
            repository.save()
            return .success(true)
        case .failure(let failure):
            self.logger?.log(failure, with: ["info": "Function: \(#function), line: \(#line)"])
            return .failure(failure)
        }
    }
    
    private func removeAllSessions() {
        let predicate = NSPredicate(format: "id == '0'")
        let allItems = repository.get(predicate: predicate, sortDescriptors: nil)
        switch allItems {
        case .success(let items):
            for i in items {
                let _ = repository.delete(entity: i)
            }
        case .failure( _):
            break
        }
    }
    
    /**
     Removes the given sessionID from Local Data.
     **/
    func removeSessions(with sessionID: String) {
        let predicate = SessionEntity.Predicates.get(sessionID: sessionID).query
        let allItems = repository.get(predicate: predicate, sortDescriptors: nil)
        switch allItems {
        case .success(let items):
            for i in items {
                let _ = repository.delete(entity: i)
            }
        case .failure( _):
            break
        }
    }
}

