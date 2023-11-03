//
//  BaseRouter.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import UIKit

protocol BaseRouter: AnyObject {
    var navigationController: UINavigationController! { get set }
    func goBack()
    func dismiss()
    func present(vc: UIViewController, style: UIModalPresentationStyle?)
    func push(vc: UIViewController)
}

extension BaseRouter {    
    func dismiss() {
        navigationController?.dismiss(animated: true)
    }

    func goBack() {
        navigationController?.popViewController(animated: true)
    }

    func present(vc: UIViewController, style: UIModalPresentationStyle?) {
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.isHidden = false
        navController.modalPresentationStyle = style ?? .fullScreen
        navigationController?.present(navController, animated: true)
    }
    
    func push(vc: UIViewController) {
        navigationController.pushViewController(vc, animated: true)
    }
}
