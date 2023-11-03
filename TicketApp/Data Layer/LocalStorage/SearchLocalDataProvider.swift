//
//  SearchLocalDataProvider.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation
import CoreData

// Protocol for managing search-related data locally
protocol SearchLocalDataProviderProtocol {
    // Get the search model
    func getSearchModel() -> BusRequestModelEntity?
    
    // Set the search model with a result indicating success or failure
    func setSearchModel(_ model: SearchDataModel) -> Result<Bool, Error>
    
    // Remove the search model
    func removeSearchModel()
}

final class SearchLocalDataProvider: SearchLocalDataProviderProtocol {
    
    private let repository: CoreDataRepository<BusRequestModelEntity>
    private let logger: ErrorLoggable?
    
    /**
     - Parameters:
     - logger: The `ErrorLoggable` logger to be used to log errors.
     */
    public init(logger: ErrorLoggable? = Logger()) {
        self.repository = CoreDataRepository<BusRequestModelEntity>()
        self.logger = logger
    }
    
    func getSearchModel() -> BusRequestModelEntity? {
        let predicate = NSPredicate(format: "id == '0'")
        let req: NSFetchRequest<BusRequestModelEntity> = BusRequestModelEntity.fetchRequest()
        req.fetchLimit = 200
        let result = repository.get(predicate: predicate, sortDescriptors: nil)
        switch result {
        case .success(let managedObject):
            if !managedObject.isEmpty {
                let last = managedObject[0]
                return last
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
    func setSearchModel(_ model: SearchDataModel) -> Result<Bool, Error> {
        removeSearchModel()
        let result = repository.create()
        switch result {
        case .success(let entity):
            entity.id = "0"
            entity.departureLocationName = model.departureLocation?.name ?? String()
            entity.departureLocationId = model.departureLocation?.id ?? Int()
            entity.arriveLocationName = model.arriveLocation?.name ?? String()
            entity.arriveLocationId = model.arriveLocation?.id ?? Int()
            entity.departureDate = DateTimeManager.shared().format(.typeRequestDate, date: model.departureDate ?? Date())
            repository.save()
            return .success(true)
        case .failure(let failure):
            self.logger?.log(failure, with: ["info": "Function: \(#function), line: \(#line)"])
            return .failure(failure)
        }
    }

    /**
     Removes the given sessionID from Local Data.
     **/
    func removeSearchModel() {
        let predicate = NSPredicate(format: "id == '0'")
        let allItems = repository.get(predicate: predicate, sortDescriptors: nil)
        switch allItems {
        case .success(let items):
            for i in items {
                let _ = repository.delete(entity: i)
            }
        case .failure(let failure):
            self.logger?.log(failure, with: ["info": "Function: \(#function), line: \(#line)"])
            break
        }
    }
}

