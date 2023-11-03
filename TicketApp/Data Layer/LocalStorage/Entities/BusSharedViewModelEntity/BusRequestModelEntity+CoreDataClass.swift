//
//  BusSharedViewModelEntity.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//


import Foundation
import CoreData

@objc(BusRequestModelEntity)
public class BusRequestModelEntity: NSManagedObject {}

extension BusRequestModelEntity {
    /// An enumeration of predefined predicates for `BusRequestModelEntity`.
    enum Predicates {
        /// - Returns: An `NSPredicate` owner case that can be used to fetch the corresponding session sessionID.
        case get(id: String)
        
        /// The predicate query for the associated case.
        var query: NSPredicate {
            switch self {
            case .get(let id):
                return NSPredicate(format: "id == %@", argumentArray: [id])
            }
        }
    }
}
