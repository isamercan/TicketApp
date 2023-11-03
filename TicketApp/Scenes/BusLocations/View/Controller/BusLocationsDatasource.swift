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
final class BusLocationsDatasource: NSObject, UICollectionViewDataSource {
    private var viewModel: BusLocationsViewModelDataProtocol
    
    init(viewModel: BusLocationsViewModelDataProtocol) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionView(numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.getSectionType(section: indexPath.section) {
        case .busLocations(items: let items):
            let cell: LocationItemCell = collectionView.dequeueReusableCell(for: indexPath)
            let item = items[indexPath.row]
            cell.setCellData(model: item)
            return cell
        }
    }
    
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
