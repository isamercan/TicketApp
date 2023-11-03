//
//  BusLocationsViewModelProtocol.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation

protocol BusLocationsViewModelProtocol: BusLocationsViewModelDataProtocol, AnyObject {
    var reload: (() -> Void)? { get set }
    var showLoading: (() -> Void)? { get set }
    var hideLoading: (() -> Void)? { get set }
    var showCollection: (() -> Void)? { get set }
    var selectedLocation: ((LocationItemDataModel) -> Void)? { get set }
    var showDataOperationFail: AlertClosureSignature! { get set }
    var viewTitle: String { get }
    var viewSubTitle: String { get }
    var isDeparture: Bool { get set }
    func fetch(query: String)
    func viewDidLoad()
}

protocol BusLocationsViewModelSelectionProtocol {
    func didTapLocation(_ indexPath: IndexPath)
}

protocol BusLocationsViewModelDataProtocol: BusLocationsViewModelSelectionProtocol {
    func numberOfSections() -> Int
    func collectionView(numberOfItemsInSection section: Int) -> Int
    func getSectionTitle(section: Int) -> String
    func getSectionType(section: Int) -> BusLocationsListSection
}


