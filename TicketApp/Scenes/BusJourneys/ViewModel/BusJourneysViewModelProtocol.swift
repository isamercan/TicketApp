//
//  FlightListViewModelProtocol.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

protocol BusJourneysViewModelProtocol: BusJourneysViewModelDataProtocol, AnyObject {
    var reload: (() -> Void)? { get set }
    var showLoading: (() -> Void)? { get set }
    var showCollection: (() -> Void)? { get set }
    var showDataOperationFail: AlertClosureSignature! { get set }
    var viewTitle: String { get }
    var viewSubTitle: String { get }
    func viewDidLoad()
}

protocol BusJourneysViewModelSelectionProtocol {
    func didTapFlight(_ indexPath: IndexPath)
    func didSelectJourney(_ indexPath: IndexPath)
}

protocol BusJourneysViewModelDataProtocol: BusJourneysViewModelSelectionProtocol {
    func numberOfSections() -> Int
    func collectionView(numberOfItemsInSection section: Int) -> Int
    func getSectionTitle(section: Int) -> String
    func getSectionType(section: Int) -> BusJourneysListSection
}


