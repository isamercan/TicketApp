//
//  BusLocationsViewModel.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//


import Foundation

final class BusLocationsViewModel: BusLocationsViewModelProtocol {
  
    private let sessionLocalDataProvider: SessionLocalDataProviderProtocol
    
    private var logger: ErrorLoggable
    private var dataProvider: BusLocationsDataProviderProtocol
    private var sections: [BusLocationsListSection] = []
    private var busLocationsList: [LocationItemDataModel] = []
    private var deviceSession: DeviceSessionModel?
    
    var reload: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showCollection: (() -> Void)?
    var selectedLocation: ((LocationItemDataModel) -> Void)?
    var showDataOperationFail: AlertClosureSignature!
    var viewTitle: String { "Bus Locations" }
    var viewSubTitle: String { "\(busLocationsList.count) found"}
    var isDeparture: Bool = false
    
    init(dataProvider: BusLocationsDataProviderProtocol, logger: ErrorLoggable) {
        self.logger = logger
        self.dataProvider = dataProvider
        self.sessionLocalDataProvider = SessionLocalDataProvider()
    }
    
    func viewDidLoad() {
        fetch(query: String())
    }
     
    private func createBaseRequestModel<T: Codable>(data: T) -> BaseRequestModel<T> {
        let deviceSession = sessionLocalDataProvider.getSession()
        let baseRequest = BaseRequestModel(deviceSession: deviceSession, date: DateTimeManager.shared().format(.calendarTextFormat, date: Date()), data: data)
        return baseRequest
    }
        
    func fetch(query: String) {
        showLoading?()
        let request: BaseRequestModel<String> = createBaseRequestModel(data: query)
        dataProvider.getBusLocations(model: request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                busLocationsList = response.data ?? []
            case .failure(let error):
                self.showDataOperationFail("Retry", error.desc) {
                    self.fetch(query: query)
                }
            }
            setupFeed()
        }
    }
    
    func setupFeed() {
        sections.removeAll()
        guard !busLocationsList.isEmpty else {
            showDataOperationFail("No Content", NSURLErrorDataNotAllowed.description) { }
            return
        }
        sections.append(.busLocations(items: self.busLocationsList))
        self.reload?()
        self.showCollection?()
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func collectionView(numberOfItemsInSection section: Int) -> Int {
        switch getSectionType(section: section) {
        case .busLocations(let items):
            return items.count
        }
    }
        
    func getSectionTitle(section: Int) -> String {
        switch getSectionType(section: section) {
        case .busLocations:
            return "Bus Locations"
        }
    }
    
    func getSectionType(section: Int) -> BusLocationsListSection {
        return sections[section]
    }

    func didTapLocation(_ indexPath: IndexPath) {
        switch getSectionType(section: indexPath.section) {
        case .busLocations(let items):
            let item = items[indexPath.row]
            selectedLocation?(item)
        }
    }
        
}
