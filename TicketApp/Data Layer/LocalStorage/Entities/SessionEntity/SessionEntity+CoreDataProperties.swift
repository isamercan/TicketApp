//
//  SessionEntity+CoreDataProperties.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import Foundation
import CoreData

extension SessionEntity: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SessionEntity> {
        return NSFetchRequest<SessionEntity>(entityName: "SessionEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var deviceID: String
    @NSManaged public var sessionID: String
}
