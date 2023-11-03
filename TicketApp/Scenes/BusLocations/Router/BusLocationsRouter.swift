//
//  BusLocationsRouter.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import UIKit

// Protocol for the bus locations router
protocol BusLocationsRouterProtocol: BaseRouter, AlertHandler, AnyObject {
    // Method to show the bus journey view controller
    func addNewLocation()
}

// Implementation of the bus locations router
final class BusLocationsRouter: BusLocationsRouterProtocol {
    var navigationController: UINavigationController!
    
    // Method to show the add New Location view controller (empty implementation)
    func addNewLocation() {}
}
