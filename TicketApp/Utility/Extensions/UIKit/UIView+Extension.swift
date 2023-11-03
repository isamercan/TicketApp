//
//  UIView+Extension.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import UIKit

extension UIView {
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
    
    
    @IBInspectable var borderWidth: CGFloat {
          set {
              layer.borderWidth = newValue
          }
          get {
              return layer.borderWidth
          }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIView {
    
    func addBorder(color: UIColor = .black, borderWidth: CGFloat = 1, roundRadius: CGFloat = 0) {
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
        layer.cornerRadius = roundRadius
        clipsToBounds = true
    }
    
    func roundCorner(_ radius: CGFloat = 2) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
