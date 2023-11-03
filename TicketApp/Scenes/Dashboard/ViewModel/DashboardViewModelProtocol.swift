//
//  FlightListViewModelProtocol.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

// Define a protocol for the dashboard view model
protocol DashboardViewModelProtocol: AnyObject {
    // Closure to trigger a reload action
    var reload: (() -> Void)? { get set }
    
    // Property to access search data model
    var searchData: SearchDataModel { get }
    
    // Closure to handle data operation failure with an alert
    var showDataOperationFail: AlertClosureSignature! { get set }
    
    // Title for the departure location
    var departureTitle: String { get }
    
    // Title for the arrival location
    var arriveTitle: String { get }
    
    // Formatted string for the departure date
    var departureDate: String { get }

    // Method called when the view model is loaded
    func viewDidLoad()
    
    // Method to toggle between departure and arrival destinations
    func toggleDestinations()
    
    // Method to set the location (departure or arrival)
    func setLocation(model: LocationItemDataModel, isDeparture: Bool)
    
    // Method to set the departure date
    func setDepartureDate(date: Date)
    
    // Method to set local data (possibly data retrieval or processing)
    func setLocalData()
    
    // Method to check the validity of the search data
    func isValidSearchData() -> Bool
}
