//
//  SessionEntity+CoreDataProperties.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import Foundation
import CoreData

extension BusRequestModelEntity: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BusRequestModelEntity> {
        return NSFetchRequest<BusRequestModelEntity>(entityName: "BusRequestModelEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var departureLocationName: String
    @NSManaged public var departureLocationId: Int
    @NSManaged public var arriveLocationName: String
    @NSManaged public var arriveLocationId: Int
    @NSManaged public var departureDate: String
}
