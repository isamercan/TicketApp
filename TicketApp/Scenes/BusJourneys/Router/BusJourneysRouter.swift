//
//  BusJourneysRouter.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import UIKit

protocol BusJourneysRouterProtocol: BaseRouter, AlertHandler, AnyObject {
    func showCheckOut()
}

final class BusJourneysRouter: BusJourneysRouterProtocol {
    var navigationController: UINavigationController!

    func showCheckOut() { }
}
