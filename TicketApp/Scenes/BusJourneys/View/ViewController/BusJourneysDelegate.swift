//
//  BusJourneysDelegate.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import UIKit

/**
    -  A `UICollectionViewDelegate` that provides data to display on a  list.
    - It is used to soften the dependency in the View and contribute to the testing process.
    - Note: This class is not thread-safe, and should be accessed from the main thread only.
 */
final class BusJourneysDelegate: NSObject, UICollectionViewDelegate {
    private let viewModel: BusJourneysViewModelSelectionProtocol
    
    // Initialize the delegate with a view model
    init(viewModel: BusJourneysViewModelSelectionProtocol) {
        self.viewModel = viewModel
    }
    
    // Called when an item in the collection view is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectJourney(indexPath)
    }
}
