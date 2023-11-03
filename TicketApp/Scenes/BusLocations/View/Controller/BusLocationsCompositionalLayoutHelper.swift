//
//  BusJourneysCompositionalLayoutHelper.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import UIKit


/**
 - Layout schema injectable into any view
*/
final class BusLocationsCompositionalLayoutHelper: CompositionalLayoutFactory {
    private let viewModel: BusLocationsViewModelDataProtocol
    
    init(viewModel: BusLocationsViewModelDataProtocol) {
        self.viewModel = viewModel
    }

    /**
     - If the number of sections is one, it creates only vertical flow.
    */
    public func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [unowned self] (section, environment) -> NSCollectionLayoutSection? in
            switch viewModel.getSectionType(section: section) {
            case .busLocations:
                return self.createBusLocationsSectionLayout()
            }
        }
    }
    
    /**
     - Creates a header that contains PairSectionHeaderView.
    */
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        return .init(layoutSize: size, elementKind: BusJourneysSectionHeaderView.reuseIdentifier, alignment: .top)
    }
    
    /**
     - Creates a vertical collection view flow with full width sliding to the bottom.
     - It has a header.
    */
    private func createBusLocationsSectionLayout() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let section = NSCollectionLayoutSection(group: .vertical(layoutSize: groupSize, subitems: [item]))
        section.interGroupSpacing = 16
        let header = createSectionHeader()
        header.contentInsets.leading = 8
        header.contentInsets.trailing = 8
        section.boundarySupplementaryItems = [header]
        
        if #available(iOS 15.0, *) {
            let window = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first
            let bottomPadding = window?.safeAreaInsets.bottom ?? 0
            section.contentInsets.bottom = bottomPadding
        }
        
        return section
    }
}
