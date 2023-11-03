//
//  AlertHandler.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import UIKit

typealias AlertClosureSignature = ((String, String, @escaping () -> Void) -> Void)

protocol AlertHandler {
    func showError(_ info: AlertInfoParameters, completion: @escaping () -> Void)
}

/// A target for fetching chart data for a specific pair.
///
/// - Parameters:
///   - completion: Void block, functionality injection
///   - info: Data to customize Alert content.
extension AlertHandler {
    func showError(_ info: AlertInfoParameters, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Error", message: info.message, preferredStyle: .alert)

        alert.addAction(
            UIAlertAction(title: info.actionTitle, style: .default, handler: { action in
                switch action.style {
                case .default:
                    completion()
                default: break
                }
            }))
        
        info.controller.present(alert, animated: true)
    }
}

struct AlertInfoParameters {
    let controller: UIViewController
    let actionTitle: String
    let message: String
}
