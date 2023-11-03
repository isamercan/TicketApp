//
//  SessionEntity+CoreDataClass.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import Foundation
import CoreData

@objc(SessionEntity)
public class SessionEntity: NSManagedObject {}

extension SessionEntity {
    /// An enumeration of predefined predicates for `SessionEntity`.
    enum Predicates {
        /// - Returns: An `NSPredicate` owner case that can be used to fetch the corresponding session sessionID.
        case get(sessionID: String)
        
        /// The predicate query for the associated case.
        var query: NSPredicate {
            switch self {
            case .get(let sessionID):
                return NSPredicate(format: "sessionID == %@", argumentArray: [sessionID])
            }
        }
    }
}
