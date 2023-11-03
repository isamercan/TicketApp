//
//  BusLocationsController.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import UIKit

protocol BusLocationsViewControllerSelectionDelegate {
    func didTapLocation(_ model: LocationItemDataModel, isDeparture: Bool)
}

final class BusLocationsViewController: BaseXIBUIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchTextField: UITextField!
    
    // MARK: - Variables
    private let viewModel: BusLocationsViewModelProtocol
    private let router: BusLocationsRouterProtocol
    private let datasource: UICollectionViewDataSource?
    private let collectionDelegate: UICollectionViewDelegate?
    private let compositionalLayoutFactory: CompositionalLayoutFactory
    
    var delegate: BusLocationsViewControllerSelectionDelegate?
    
    // MARK: - Lifecycle Methods
    init(dependencies: Dependencies) {
        self.viewModel = dependencies.model
        self.datasource = dependencies.datasource
        self.collectionDelegate = dependencies.collectionDelegate
        self.compositionalLayoutFactory = dependencies.compositionalLayoutFactory
        self.router = BusLocationsRouter()
        super.init()
        self.bindViewModelProperties()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        router.navigationController = self.navigationController!
        viewModel.viewDidLoad()
        setupTextField()
        applyCollectionViewSettings()
    }
}


// MARK: - Private helpers
extension BusLocationsViewController {
    private func setupTextField() {
        searchTextField.delegate = self
        searchTextField.returnKeyType = .done
    }
    
    private func applyCollectionViewSettings() {
        collectionView.registerCells(LocationItemCell.self)
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
        viewModel.selectedLocation = selectedLocation()
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
                self?.searchTextField.alpha = 1
            }
            self?.loadingIndicator.stopAnimating()
        }
    }
    
    private func selectedLocation() -> (LocationItemDataModel) -> Void {
        return { [weak self] location in
            self?.router.dismiss()
            self?.delegate?.didTapLocation(location, isDeparture: self?.viewModel.isDeparture ?? false)
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
extension BusLocationsViewController {
    struct Dependencies {
        let model: BusLocationsViewModelProtocol
        let datasource: UICollectionViewDataSource
        let collectionDelegate: UICollectionViewDelegate
        let compositionalLayoutFactory: CompositionalLayoutFactory
    }
}

extension BusLocationsViewController.Dependencies {
    static func `default`(viewModel: BusLocationsViewModelProtocol) -> Self {
        return .init(
            model: viewModel,
            datasource:  BusLocationsDatasource(viewModel: viewModel),
            collectionDelegate: BusLocationsDelegate(viewModel: viewModel),
            compositionalLayoutFactory: BusLocationsCompositionalLayoutHelper(viewModel: viewModel)
        )
    }
}



extension BusLocationsViewController: UITextFieldDelegate {
   func textFieldDidEndEditing(_ textField: UITextField) {
       let text = textField.text ?? ""
       viewModel.fetch(query: text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text)
        let text = textField.text ?? "" + string
        if text.count >= 3  {
            viewModel.fetch(query: text)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
