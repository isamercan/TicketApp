//
//  BusJourneysViewModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

// Define a concrete class for the dashboard view model that conforms to the protocol
final class DashboardViewModel: DashboardViewModelProtocol {
    // Closures and properties required by the protocol
    
    // Closure to trigger a reload action
    var reload: (() -> Void)?
    
    // Closure to handle data operation failure with an alert
    var showDataOperationFail: AlertClosureSignature!
    
    // Property to access search data model
    var searchData: SearchDataModel
    
    // Computed property for the departure location title
    var departureTitle: String { searchData.departureLocation?.name ?? "Kalkış Noktası Seçin" }
    
    // Computed property for the arrival location title
    var arriveTitle: String { searchData.arriveLocation?.name ?? "Varış Noktası Seçin" }
    
    // Computed property for the formatted departure date
    var departureDate: String { DateTimeManager.shared().format(.searchDateFormat, date: searchData.departureDate ?? Date.tomorrow) }
    
    // Private properties for data providers and logging
    private let searchLocalDataProvider: SearchLocalDataProviderProtocol
    private let logger: ErrorLoggable

    // Initialize the view model with a logger and create an empty search data model
    init(logger: ErrorLoggable) {
        self.logger = logger
        searchData = SearchDataModel()
        searchLocalDataProvider = SearchLocalDataProvider()
    }

    // Method called when the view model is loaded
    func viewDidLoad() {
        fetch()
    }

    // Private method to fetch data from a local data provider
    private func fetch() {
        if let data = searchLocalDataProvider.getSearchModel() {
            searchData.departureDate = DateTimeManager.shared().formatToDate(.typeRequestDate, dateString: data.departureDate)
            searchData.departureLocation = LocationItemDataModel(id: data.departureLocationId, name: data.departureLocationName)
            searchData.arriveLocation = LocationItemDataModel(id: data.arriveLocationId, name: data.arriveLocationName)
        }
        reload?()
    }

    // Method to toggle departure and arrival destinations
    func toggleDestinations() {
        guard let tempArrive = searchData.departureLocation, let tempDeparture = searchData.arriveLocation else { return }
        setLocation(model: tempArrive, isDeparture: false)
        setLocation(model: tempDeparture, isDeparture: true)
    }

    // Method to set a location (departure or arrival)
    func setLocation(model: LocationItemDataModel, isDeparture: Bool) {
        if isDeparture {
            searchData.departureLocation = model
        } else {
            searchData.arriveLocation = model
        }
        reload?()
    }

    // Method to set the departure date
    func setDepartureDate(date: Date) {
        searchData.departureDate = date
        reload?()
    }

    // Method to check the validity of the search data
    func isValidSearchData() -> Bool {
        guard searchData.arriveLocation != searchData.departureLocation else {
            self.showDataOperationFail("Varış noktası Seçin", "Varış noktası farklı olmalı") { }
            return false
        }

        guard searchData.arriveLocation != nil, searchData.departureLocation != nil, searchData.departureDate != nil else {
            self.showDataOperationFail("Retry", "Data Not found") { }
            return false
        }

        return true
    }

    // Method to set local data
    func setLocalData() {
        let _ = searchLocalDataProvider.setSearchModel(searchData)
    }
}
