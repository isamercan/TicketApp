//
//  BusJourneysDatasource.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//


import UIKit

/**
    -  A `UICollectionViewDataSource` that provides data to display on a pair list.
    - It is used to soften the dependency in the View and contribute to the testing process.
    - Note: This class is not thread-safe, and should be accessed from the main thread only.
 */

final class BusJourneysDatasource: NSObject, UICollectionViewDataSource {
    private var viewModel: BusJourneysViewModelDataProtocol
    
    // Initialize the data source with a view model
    init(viewModel: BusJourneysViewModelDataProtocol) {
        self.viewModel = viewModel
    }
    
    // Number of sections in the collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    // Number of items in a specific section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionView(numberOfItemsInSection: section)
    }
    
    // Create and configure cells for collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.getSectionType(section: indexPath.section) {
        case .info:
            let cell: InfoCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(title: "About Header")
            return cell
        case .busJourneys(items: let items):
            let cell: JourneyItemCell = collectionView.dequeueReusableCell(for: indexPath)
            let item = items[indexPath.row]
            cell.setCellData(model: item)
            return cell
        }
    }
    
    // Create and configure section header views
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let view: BusJourneysSectionHeaderView = collectionView.dequeueReusableSupplementaryView(for: kind, at: indexPath)
        view.setup(title: viewModel.getSectionTitle(section: indexPath.section))
        return view
    }
}
