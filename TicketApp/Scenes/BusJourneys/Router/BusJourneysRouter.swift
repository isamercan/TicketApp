//
//  BusJourneysRouter.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import UIKit

// Define a protocol for the bus journeys router
protocol BusJourneysRouterProtocol: BaseRouter, AlertHandler, AnyObject {
    // Method to navigate to the check-out screen
    func showCheckOut()
}

// Define a class that conforms to the BusJourneysRouterProtocol
final class BusJourneysRouter: BusJourneysRouterProtocol {
    // Property to manage navigation
    var navigationController: UINavigationController!

    // Method to show the check-out screen
    func showCheckOut() {
        // Implementation details for navigating to the check-out screen
    }
}
