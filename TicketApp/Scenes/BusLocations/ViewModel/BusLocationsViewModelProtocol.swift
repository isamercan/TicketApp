//
//  BusLocationsViewModelProtocol.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation

// Protocol for the bus locations view model
protocol BusLocationsViewModelProtocol: BusLocationsViewModelDataProtocol, AnyObject {
    // A closure to trigger data reload in the view
    var reload: (() -> Void)? { get set }
    
    // A closure to show a loading indicator
    var showLoading: (() -> Void)? { get set }
    
    // A closure to hide the loading indicator
    var hideLoading: (() -> Void)? { get set }
    
    // A closure to show the collection view
    var showCollection: (() -> Void)? { get set }
    
    // A closure to handle the selection of a location
    var selectedLocation: ((LocationItemDataModel) -> Void)? { get set }
    
    // A closure to handle data operation failures with an alert
    var showDataOperationFail: AlertClosureSignature! { get set }
    
    // The title of the view
    var viewTitle: String { get }
    
    // The subtitle of the view
    var viewSubTitle: String { get }
    
    // A flag to indicate whether it's for departure or not
    var isDeparture: Bool { get set }
    
    // Fetch data based on a query
    func fetch(query: String)
    
    // Called when the view loads
    func viewDidLoad()
}

// Protocol for handling location selection actions
protocol BusLocationsViewModelSelectionProtocol {
    // Handle the tap on a location at a specific indexPath
    func didTapLocation(_ indexPath: IndexPath)
}

// Protocol for the data-related aspects of the bus locations view model
protocol BusLocationsViewModelDataProtocol: BusLocationsViewModelSelectionProtocol {
    // Get the number of sections in the collection view
    func numberOfSections() -> Int
    
    // Get the number of items in a specific section of the collection view
    func collectionView(numberOfItemsInSection section: Int) -> Int
    
    // Get the title for a specific section
    func getSectionTitle(section: Int) -> String
    
    // Get the type of a section from an enumeration
    func getSectionType(section: Int) -> BusLocationsListSection
}
