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
// Enum representing different view controllers
enum Controllers {
    case dashboard
    case busLocations(isDeparture: Bool)
    case busJourney(model: SearchDataModel)
    
    // Computed property that returns the appropriate UIViewController based on the enum case
    var controller: UIViewController {
        switch self {
        case .dashboard:
            // Create a DashboardViewModel with a Logger and initialize a DashboardViewController with default dependencies
            let viewModel = DashboardViewModel(logger: Logger())
            return DashboardViewController(dependencies: .default(viewModel: viewModel))
        case .busLocations(let isDeparture):
            // Create a BusLocationsViewModel with a data provider and a Logger, set the departure flag, and initialize a BusLocationsViewController with default dependencies
            let viewModel = BusLocationsViewModel(dataProvider: BusLocationsDataProvider(), logger: Logger())
            viewModel.isDeparture = isDeparture
            return BusLocationsViewController(dependencies: .default(viewModel: viewModel))
        case .busJourney(let model):
            // Create a BusJourneysViewModel with search data, a data provider, and a Logger, and initialize a BusJourneysViewController with default dependencies
            let viewModel = BusJourneysViewModel(searchData: model, dataProvider: BusJourneyDataProvider(), logger: Logger())
            return BusJourneysViewController(dependencies: .default(viewModel: viewModel))
        }
    }
}
