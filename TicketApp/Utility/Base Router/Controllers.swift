//
//  Controllers.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//


import UIKit

/**
 Returns the appropriate UIViewController based on the current enum case.

 - Returns: A new instance of the appropriate UIViewController.

 ````
 let controller = Controllers.busJourney(model: model).controller
 self.navigationController?.pushViewController(controller, animated: true)
 ````
*/
enum Controllers {
    case dashboard
    case busLocations(isDeparture: Bool)
    case busJourney(model: SearchDataModel)
    
    var controller: UIViewController {
        switch self {
        case .dashboard:
            let viewModel = DashboardViewModel(logger: Logger())
            return DashboardViewController(dependencies: .default(viewModel: viewModel))
        case .busLocations(let isDeparture):
            let viewModel = BusLocationsViewModel(dataProvider: BusLocationsDataProvider(), logger: Logger())
            viewModel.isDeparture = isDeparture
            return BusLocationsViewController(dependencies: .default(viewModel: viewModel))
        case .busJourney(let model):
            let viewModel = BusJourneysViewModel(searchData: model, dataProvider: BusJourneyDataProvider(), logger: Logger())
            return BusJourneysViewController(dependencies: .default(viewModel: viewModel))
        }
    }
}
