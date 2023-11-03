//
//  UIView+Extension.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import UIKit

extension UIView {
    // IBInspectable property to set the border color in Interface Builder
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    // IBInspectable property to set the border width in Interface Builder
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    // IBInspectable property to set the corner radius in Interface Builder
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIView {
    // Method to add a border with custom color, width, and round radius
    func addBorder(color: UIColor = .black, borderWidth: CGFloat = 1, roundRadius: CGFloat = 0) {
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
        layer.cornerRadius = roundRadius
        clipsToBounds = true
    }
    
    // Method to round the corners with a specified radius
    func roundCorner(_ radius: CGFloat = 2) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

