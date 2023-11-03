//
//  BusJourneysViewController.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import UIKit

final class BusJourneysViewController: BaseXIBUIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    private let viewModel: BusJourneysViewModelProtocol
    private let router: BusJourneysRouterProtocol
    private let datasource: UICollectionViewDataSource?
    private let collectionDelegate: UICollectionViewDelegate?
    private let compositionalLayoutFactory: CompositionalLayoutFactory
    
    // MARK: - Lifecycle Methods
    init(dependencies: Dependencies) {
        self.viewModel = dependencies.model
        self.datasource = dependencies.datasource
        self.collectionDelegate = dependencies.collectionDelegate
        self.compositionalLayoutFactory = dependencies.compositionalLayoutFactory
        self.router = BusJourneysRouter()
        super.init()
        self.bindViewModelProperties()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the navigation bar
        configureNavigationBar()
        
        // Set the navigation controller for the router
        router.navigationController = self.navigationController!
        
        // Call the viewDidLoad method of the view model
        viewModel.viewDidLoad()
        
        // Apply settings to the collection view
        applyCollectionViewSettings()
    }
}

// MARK: - Private helpers
extension BusJourneysViewController {
    
    private func applyCollectionViewSettings() {
        collectionView.registerCells(InfoCell.self, JourneyItemCell.self)
        collectionView.registerHeaders(BusJourneysSectionHeaderView.self)
        collectionView.dataSource = datasource
        collectionView.delegate = collectionDelegate
        collectionView.collectionViewLayout = compositionalLayoutFactory.layout()
        collectionView.reloadData()
    }
    
    private func bindViewModelProperties() {
        viewModel.reload = reload()
        viewModel.showCollection = showCollection()
        viewModel.showDataOperationFail = showDataOperationFail()
    }
    
    private func reload() -> () -> Void {
        return { [weak self] in
            guard let self else { return }
            collectionView.reloadData()
            navigationItem.titleView = setTitle(title: viewModel.viewTitle, subtitle: viewModel.viewSubTitle)
        }
    }
        
    private func showCollection() -> () -> Void {
        return { [weak self] in
            UIView.animate(withDuration: 1) {
                self?.collectionView.alpha = 1
            }
            
            self?.loadingIndicator.stopAnimating()
        }
    }
    
    private func showDataOperationFail() -> AlertClosureSignature {
        return { [weak self] actionTitle, message, action in
            if let self {
                self.router.showError(.init(controller: self, actionTitle: actionTitle, message: message), completion: action)                
            }
        }
    }
}

// MARK: - Quick initial/injection environment
extension BusJourneysViewController {
    // A structure to define dependencies for the view controller
    struct Dependencies {
        let model: BusJourneysViewModelProtocol
        let datasource: UICollectionViewDataSource
        let collectionDelegate: UICollectionViewDelegate
        let compositionalLayoutFactory: CompositionalLayoutFactory
    }
}

extension BusJourneysViewController.Dependencies {
    // A static method to provide default dependencies
    static func `default`(viewModel: BusJourneysViewModelProtocol) -> Self {
        return .init(
            model: viewModel,
            datasource:  BusJourneysDatasource(viewModel: viewModel),
            collectionDelegate: BusJourneysDelegate(viewModel: viewModel),
            compositionalLayoutFactory: BusJourneysCompositionalLayoutHelper(viewModel: viewModel)
        )
    }
}
