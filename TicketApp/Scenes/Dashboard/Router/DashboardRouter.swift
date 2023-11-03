//
//  BusLocationsRouter.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import UIKit

// Define a protocol for the dashboard router
protocol DashboardRouterRouterProtocol: BaseRouter, AlertHandler, AnyObject {
    // Method to show bus locations with a delegate and departure flag
    func showLocations(delegate: BusLocationsViewControllerSelectionDelegate, isDeparture: Bool)
    
    // Method to show bus journey with a search data model
    func showBusJourney(model: SearchDataModel)
}

// Define a class that conforms to the DashboardRouterRouterProtocol
final class DashboardRouter: DashboardRouterRouterProtocol {
    // Property to store the navigation controller
    var navigationController: UINavigationController!
    
    // Implement the method to show bus locations
    func showLocations(delegate: BusLocationsViewControllerSelectionDelegate, isDeparture: Bool) {
        // Create a BusLocationsViewController instance
        let locationsVC = Controllers.busLocations(isDeparture: isDeparture).controller as! BusLocationsViewController
        // Set the delegate
        locationsVC.delegate = delegate
        // Present the view controller as a form sheet
        present(vc: locationsVC, style: .formSheet)
    }
    
    // Implement the method to show bus journey
    func showBusJourney(model: SearchDataModel) {
        // Create a bus journey view controller instance
        let busJourneyVC = Controllers.busJourney(model: model).controller
        // Push the view controller onto the navigation stack
        push(vc: busJourneyVC)
    }
}
