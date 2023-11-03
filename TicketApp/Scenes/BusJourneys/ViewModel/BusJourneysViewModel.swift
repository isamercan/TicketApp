//
//  BusJourneysViewModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

final class BusJourneysViewModel: BusJourneysViewModelProtocol {
    
    private let dataProvider: BusJourneyDataProvider
    private let sessionLocalDataProvider: SessionLocalDataProviderProtocol
    private let logger: ErrorLoggable
    //private let requestData: GetBusJourneyRequestDataModel
    private let searchData: SearchDataModel

    private var sections: [BusJourneysListSection] = []
    private var busjourneysList: [JourneyItemDataModel] = []
    
    var reload: (() -> Void)?
    var showLoading: (() -> Void)?
    var showCollection: (() -> Void)?
    var showDataOperationFail: AlertClosureSignature!
    var viewTitle: String { busjourneysList.first?.fullDestination ?? String()}
    var viewSubTitle: String {  DateTimeManager.shared().format(.listDateFormat, date: busjourneysList.first?.journey?.departure ?? String())}
    
    init(searchData: SearchDataModel, dataProvider: BusJourneyDataProvider, logger: ErrorLoggable) {
        self.searchData = searchData
        self.logger = logger
        self.dataProvider = dataProvider
        self.sessionLocalDataProvider = SessionLocalDataProvider()
    }
    
    func viewDidLoad() {
        fetch()
    }
    
    
    // Private function to create search request data
    private func createSearchRequestData() -> GetBusJourneyRequestDataModel? {
        // Check if departureLocation and arriveLocation have valid IDs
        guard let originID = searchData.departureLocation?.id,
              let destinationID = searchData.arriveLocation?.id else {
            return nil
        }
        
        // Format the departure date using DateTimeManager
        let departureDate = DateTimeManager.shared().format(.typeRequestDate, date: searchData.departureDate ?? Date.tomorrow)
        
        // Create and return the GetBusJourneyRequestDataModel
        return GetBusJourneyRequestDataModel(originID: originID, destinationID: destinationID, departureDate: departureDate)
    }
    
    // Private function to create a BaseRequestModel
    private func createBaseRequestModel<T: Codable>(data: T) -> BaseRequestModel<T> {
        // Get the device session from the sessionLocalDataProvider
        let deviceSession = sessionLocalDataProvider.getSession()
        
        // Get the current date and format it using DateTimeManager
        let currentDate = DateTimeManager.shared().format(.calendarTextFormat, date: Date())
        
        // Create and return the BaseRequestModel with the provided data, device session, and current date
        let baseRequest = BaseRequestModel(deviceSession: deviceSession, date: currentDate, data: data)
        return baseRequest
    }
    
    private func fetch() {
        showLoading?()
        guard let requestData = createSearchRequestData() else {
            self.showDataOperationFail("Retry", "Data Not found") { }
            return
        }
        
        let request: BaseRequestModel<GetBusJourneyRequestDataModel> = createBaseRequestModel(data: requestData)
        dataProvider.getBusJourneys(request: request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                busjourneysList = response.data ?? []
                setupFeed()
            case .failure(let error):
                self.showDataOperationFail("Retry", error.desc) {
                    self.fetch()
                }
            }
        }
    }
    
    
    // Function to set up the feed
    func setupFeed() {
        // Remove any existing sections
        sections.removeAll()
        
        // Check if the busjourneysList is not empty
        guard !busjourneysList.isEmpty else {
            // If it's empty, show a data operation failure with a message and description
            showDataOperationFail("No Content", NSURLErrorDataNotAllowed.description) { }
            return
        }
        
        // If the busjourneysList is not empty, create a section with the busJourneys items
        sections.append(.busJourneys(items: self.busjourneysList))
        
        // Notify the view to reload and show the collection
        self.reload?()
        self.showCollection?()
    }

    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func collectionView(numberOfItemsInSection section: Int) -> Int {
        switch getSectionType(section: section) {
        case .info:
            return 1
        case .busJourneys(let items):
            return items.count
        }
    }
        
    func getSectionTitle(section: Int) -> String {
        switch getSectionType(section: section) {
        case .info:
            return "Info"
        case .busJourneys:
            return "Bus Journeys"
        }
    }
    
    func getSectionType(section: Int) -> BusJourneysListSection {
        return sections[section]
    }
    
    func didTapFlight(_ indexPath: IndexPath) {
        switch getSectionType(section: indexPath.section) {
        case .busJourneys(let items):
            let _ = items[indexPath.row]
        default:
            break
        }
    }
    
    func didSelectJourney(_ indexPath: IndexPath) { }
}
