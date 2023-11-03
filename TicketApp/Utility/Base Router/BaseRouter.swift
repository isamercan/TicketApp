//
//  BaseRouter.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import UIKit

// Protocol for a base router
protocol BaseRouter: AnyObject {
    var navigationController: UINavigationController! { get set }
    func goBack()
    func dismiss()
    func present(vc: UIViewController, style: UIModalPresentationStyle?)
    func push(vc: UIViewController)
}

// Default implementations for the BaseRouter methods
extension BaseRouter {
    // Dismiss the current view controller
    func dismiss() {
        navigationController?.dismiss(animated: true)
    }

    // Navigate back in the navigation stack
    func goBack() {
        navigationController?.popViewController(animated: true)
    }

    // Present a view controller modally with an optional presentation style
    func present(vc: UIViewController, style: UIModalPresentationStyle?) {
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.isHidden = false
        navController.modalPresentationStyle = style ?? .fullScreen
        navigationController?.present(navController, animated: true)
    }
    
    // Push a view controller onto the navigation stack
    func push(vc: UIViewController) {
        navigationController.pushViewController(vc, animated: true)
    }
}
