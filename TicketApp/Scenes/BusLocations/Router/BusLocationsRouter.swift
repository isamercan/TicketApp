//
//  BusLocationsRouter.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import UIKit

protocol BusLocationsRouterProtocol: BaseRouter, AlertHandler, AnyObject {
    func showBusJourneyVC()
}

final class BusLocationsRouter: BusLocationsRouterProtocol {
    
    var navigationController: UINavigationController!
    func showBusJourneyVC() {}
}
