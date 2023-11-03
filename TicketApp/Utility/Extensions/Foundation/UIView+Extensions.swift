//
//  UIView+Extensions.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import UIKit

extension UIView {
    
    /// Returns the reuse identifier of the UIView, which is the name of the class as a string
    ///
    /// Example: "MyCustomView"
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
    /// Returns the UINib object for the UIView, which is a nib file that contains the view and its associated objects
    ///
    /// Example: `UINib(nibName: "MyCustomView", bundle: Bundle(for: MyCustomView.self))`
    @objc class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}
