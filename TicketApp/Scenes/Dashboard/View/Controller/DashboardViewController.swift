//
//  DashboardViewController.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import UIKit



class DashboardViewController: BaseXIBUIViewController {
    
    // MARK: - Variables
    private let viewModel: DashboardViewModelProtocol
    private let router: DashboardRouterRouterProtocol
    
    //MARK: - Outlets
    @IBOutlet private weak var arriveStackView: UIStackView!
    @IBOutlet private weak var departureStackView: UIStackView!
    @IBOutlet private weak var lblDepartureTitle: UILabel!
    @IBOutlet private weak var lblArriveTitle: UILabel!
    @IBOutlet private weak var lblDepartureDate: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    @IBOutlet private weak var btnSetToday: CustomButton!
    @IBOutlet private weak var btnSetTomorrow: CustomButton!
    @IBOutlet private weak var btnSearch: CustomButton!
    
    let datePicker = UIDatePicker()
    
    private enum LocationViewTags: Int, CaseIterable {
        case origin
        case destination
        
        var isDeparture: Bool {
            switch self {
            case .origin:
                return true
            case .destination:
                return false
            }
        }
    }
    
    // MARK: - Lifecycle Methods
    init(dependencies: Dependencies) {
        self.viewModel = dependencies.model
        self.router = DashboardRouter()
        super.init()
        self.bindViewModelProperties()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        router.navigationController = self.navigationController!
        viewModel.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        addGestureRecognizers()
        setupDatePickerForTextField(textField)
    }
}

// MARK: - Actions
extension DashboardViewController {
    // Action for the search button
    @IBAction func btnSearchAction(_ sender: CustomButton) {
        // Check the validity of search data using the view model
        guard viewModel.isValidSearchData() else { return }
        // Set local data and navigate to the bus journey view
        viewModel.setLocalData()
        router.showBusJourney(model: viewModel.searchData)
    }
    
    // Action for setting the date
    @IBAction func setDateAction(_ sender: CustomButton) {
        // Determine the date based on the tag of the button (0 for today, 1 for tomorrow)
        let date = sender.tag == 0 ? Date.today : Date.tomorrow
        viewModel.setDepartureDate(date: date)
    }
    
    // Action to toggle departure and arrival destinations
    @IBAction func toggleAction(_ sender: Any) {
        viewModel.toggleDestinations()
    }
}


// MARK: - Private helpers
extension DashboardViewController {
    
    private func addGestureRecognizers() {
        let departureGesture = UITapGestureRecognizer(target: self, action: #selector(locationsViewTapped))
        let arriveGesture = UITapGestureRecognizer(target: self, action: #selector(locationsViewTapped))
        departureStackView.addGestureRecognizer(departureGesture)
        arriveStackView.addGestureRecognizer(arriveGesture)
    }
    
    @objc func locationsViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended, let tag = sender.view?.tag  {
            let sender = LocationViewTags(rawValue: tag) ?? .origin
            router.showLocations(delegate: self, isDeparture: sender.isDeparture)
        }
    }
    
    private func setData() {
        lblDepartureTitle.text = viewModel.departureTitle
        lblArriveTitle.text = viewModel.arriveTitle
        lblDepartureDate.text = viewModel.departureDate
        datePicker.date = viewModel.searchData.departureDate ?? Date.tomorrow
    }
    
    private func bindViewModelProperties() {
        viewModel.reload = reload()
        viewModel.showDataOperationFail = showDataOperationFail()
    }
    
    private func reload() -> () -> Void {
        return { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.setData()
            }
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
extension DashboardViewController {
    struct Dependencies {
        let model: DashboardViewModelProtocol
    }
}

extension DashboardViewController.Dependencies {
    static func `default`(viewModel: DashboardViewModelProtocol) -> Self {
        return .init(
            model: viewModel
        )
    }
}

extension DashboardViewController: BusLocationsViewControllerSelectionDelegate {
    func didTapLocation(_ model: LocationItemDataModel, isDeparture: Bool) {
        viewModel.setLocation(model: model, isDeparture: isDeparture)
    }
}

// MARK: - Private helpers
extension DashboardViewController {
    
    func setupDatePickerForTextField(_ textField: UITextField) {
        // This function sets up a UIDatePicker as an input view for a given UITextField
        // and configures it to allow selecting a date starting from tomorrow.

        // Create a toolbar with a "Done" button to dismiss the picker.
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonClicked))
        toolbar.setItems([doneButton], animated: true)
        
        // Set the toolbar as the input accessory view for the text field.
        textField.inputAccessoryView = toolbar
        
        // Set the datePicker as the input view for the text field.
        textField.inputView = datePicker
        
        // Configure the datePicker settings.
        datePicker.minimumDate = Date.today
        datePicker.date = viewModel.searchData.departureDate ?? Date.tomorrow
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }
    
    @objc func doneButtonClicked() {
        viewModel.setDepartureDate(date: datePicker.date)
        self.view.endEditing(true)
    }
}
