//
//  BaseXIBUIViewController.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import UIKit

open class BaseXIBUIViewController: UIViewController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    public init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: Self.self))
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    } 
}
