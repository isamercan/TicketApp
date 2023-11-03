//
//  CoreDataRepositoryProtocol.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation

protocol CoreDataRepositoryProtocol {
    /// The entity managed by the repository.
    associatedtype Entity

    /// Gets an array of entities.
    /// - Parameters:
    ///   - predicate: The predicate to be used for fetching the entities.
    ///   - sortDescriptors: The sort descriptors used for sorting the returned array of entities.
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error>

    /// Creates an entity.
    func create() -> Result<Entity, Error>

    /// Deletes an entity.
    /// - Parameter entity: The entity to be deleted.
    func delete(entity: Entity) -> Result<Bool, Error>
}
