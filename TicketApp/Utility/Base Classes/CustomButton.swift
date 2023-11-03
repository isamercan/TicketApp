//
//  CustomButton.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 3.11.2023.
//

import UIKit

enum CustomButtonStyle: Int {
    case gray, outline, blue
    
    init() {
        self = .blue
    }
    
    init(value: Int) {
        var result: CustomButtonStyle = CustomButtonStyle()
        switch value {
        case CustomButtonStyle.gray.rawValue:
            result = CustomButtonStyle.gray
        case CustomButtonStyle.outline.rawValue:
            result = CustomButtonStyle.outline
        case CustomButtonStyle.blue.rawValue:
            result = CustomButtonStyle.blue
        default:
            break
        }
        self = result
    }
    
    var bgColor: UIColor {
        switch self {
        case .blue:
            return .systemBlue
        case .gray:
            return .gray
        case .outline:
            return .clear
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .blue:
            return .white
        case .gray:
            return .white
        case .outline:
            return .gray
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .blue:
            return .systemBlue
        case .gray:
            return .gray
        case .outline:
            return .gray
        }
    }
    
    var arrow: UIImage? {
        switch self {
        default:
            return UIImage(named: "buttonArrow-black")
        }
    }
}

@IBDesignable
class CustomButton: UIButton {
    private var customStyle: CustomButtonStyle = CustomButtonStyle()
    
    var originalButtonText: String?
    var originalButtonImage: UIImage?
    var activityIndicator: UIActivityIndicatorView!
    
    @IBInspectable var style: Int = CustomButtonStyle.blue.rawValue {
        didSet {
            customStyle = CustomButtonStyle(value: style)
            backgroundColor = customStyle.bgColor
            setTitleColor(customStyle.textColor, for: .normal)
            addBorder(color: customStyle.borderColor, borderWidth: 1, roundRadius: 1)
            titleLabel?.font = .boldSystemFont(ofSize: 17)
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var hasArrow: Bool = false {
        didSet {
            let title = title(for: .normal) ?? ""
            setImage(hasArrow ? customStyle.arrow : nil, for: .normal)
            setTitle(title + (hasArrow ? " ":""), for: .normal)
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        roundCorner(8)
        titleLabel?.font = .boldSystemFont(ofSize: 17)
        semanticContentAttribute = .forceRightToLeft
    }
    
    func showButtonLoading(_ color: UIColor = .white) {
        self.isUserInteractionEnabled = false
        originalButtonText = self.titleLabel?.text
        originalButtonImage = self.imageView?.image
        self.setTitle("", for: UIControl.State())
        self.setImage(UIImage(), for: UIControl.State())
        if activityIndicator == nil {
            activityIndicator = createActivityIndicator()
        }
        activityIndicator.color = color
        showSpinning()
    }

    func hideButtonLoading() {
        self.isUserInteractionEnabled = true
        if activityIndicator != nil {
            self.setTitle(originalButtonText, for: UIControl.State())
            self.setImage(originalButtonImage, for: UIControl.State())
            activityIndicator.stopAnimating()
        }
    }

    fileprivate func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }

    fileprivate func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }

    fileprivate func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
