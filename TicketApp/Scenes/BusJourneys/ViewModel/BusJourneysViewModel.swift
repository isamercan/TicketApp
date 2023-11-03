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
    
    private func createBaseRequestModel<T: Codable>(data: T) -> BaseRequestModel<T> {
        let deviceSession = sessionLocalDataProvider.getSession()
        let baseRequest = BaseRequestModel(deviceSession: deviceSession, date: DateTimeManager.shared().format(.calendarTextFormat, date: Date()), data: data)
        return baseRequest
    }
        
    private func createSearchRequestData() -> GetBusJourneyRequestDataModel? {
        guard let originID = searchData.departureLocation?.id,
                let destinationID = searchData.arriveLocation?.id else { return nil }
        let departureDate = DateTimeManager.shared().format(.typeRequestDate, date: searchData.departureDate ?? Date.tomorrow)
        return GetBusJourneyRequestDataModel(originID: originID, destinationID: destinationID, departureDate: departureDate)
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
    
    
    func setupFeed() {
        sections.removeAll()
        guard !busjourneysList.isEmpty else {
            showDataOperationFail("No Content", NSURLErrorDataNotAllowed.description) { }
            return
        }
        sections.append(.busJourneys(items: self.busjourneysList))
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
            let item = items[indexPath.row]
        default:
            break
        }
    }
    
    func didSelectJourney(_ indexPath: IndexPath) {
        
    }
    
        
}


extension BusJourneysViewModel {
//    func getSession() async throws -> DeviceSessionModel {
//        return try await withCheckedThrowingContinuation({ continuation in
//            sessionLocalDataProvider.getSession { result in
//                switch result {
//                case .success(let deviceSession):
//                    continuation.resume(with: .success(deviceSession))
//                case .failure(let error):
//                    continuation.resume(with: .failure(error))
//                }
//            }
//        })
//    }
}
