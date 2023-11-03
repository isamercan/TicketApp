//
//  BusJourneysViewModelProtocol.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

// Protocol for the main bus journeys view model
protocol BusJourneysViewModelProtocol: BusJourneysViewModelDataProtocol, AnyObject {
    // Closure to trigger a reload action
    var reload: (() -> Void)? { get set }
    
    // Closure to show loading state
    var showLoading: (() -> Void)? { get set }
    
    // Closure to update the collection view
    var showCollection: (() -> Void)? { get set }
    
    // Closure to handle data operation failure with an alert
    var showDataOperationFail: AlertClosureSignature! { get set }
    
    // Title for the bus journeys view
    var viewTitle: String { get }
    
    // Subtitle for the bus journeys view
    var viewSubTitle: String { get }
    
    // Method called when the view model is loaded
    func viewDidLoad()
}

// Protocol for selection-related functionality in the bus journeys view model
protocol BusJourneysViewModelSelectionProtocol {
    // Method called when a flight item is tapped
    func didTapFlight(_ indexPath: IndexPath)
    
    // Method called when a bus journey is selected
    func didSelectJourney(_ indexPath: IndexPath)
}

// Protocol for data-related functionality in the bus journeys view model
protocol BusJourneysViewModelDataProtocol: BusJourneysViewModelSelectionProtocol {
    // Method to get the number of sections
    func numberOfSections() -> Int
    
    // Method to get the number of items in a specific section of the collection view
    func collectionView(numberOfItemsInSection section: Int) -> Int
    
    // Method to get the title for a specific section
    func getSectionTitle(section: Int) -> String
    
    // Method to get the type of a specific section
    func getSectionType(section: Int) -> BusJourneysListSection
}
