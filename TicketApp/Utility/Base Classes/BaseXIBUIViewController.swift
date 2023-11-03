//
//  BaseXIBUIViewController.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import UIKit

open class BaseXIBUIViewController: UIViewController {
    // Override to set the preferred status bar style to light content
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // Custom initializer that sets the nib name and bundle for the view controller
    public init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: Self.self))
    }
    
    // Required initializer that is marked as unavailable, preventing its use
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
