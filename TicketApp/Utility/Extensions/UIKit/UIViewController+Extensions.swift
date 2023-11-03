//
//  UIViewController+Extensions.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import UIKit

extension UIViewController {
    func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.hidesBackButton = false
        self.navigationItem.backButtonTitle = nil
        self.navigationController?.navigationBar.backItem?.title = String()
    }
    
    func setTitle(title:String, subtitle:String) -> UIView {

            let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))

            titleLabel.backgroundColor = UIColor.clear
            titleLabel.textColor = UIColor.white
            titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
            titleLabel.text = title
            titleLabel.sizeToFit()

            let subtitleLabel = UILabel(frame: CGRect(x:0, y:18, width:0, height:0))
            subtitleLabel.backgroundColor = .clear
            subtitleLabel.textColor = .white
            subtitleLabel.font = UIFont.systemFont(ofSize: 15)
            subtitleLabel.text = subtitle
            subtitleLabel.sizeToFit()


            let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
            titleView.addSubview(titleLabel)
            titleView.addSubview(subtitleLabel)

            let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

            if widthDiff < 0 {
                let newX = widthDiff / 2
                subtitleLabel.frame.origin.x = abs(newX)
            } else {
                let newX = widthDiff / 2
                titleLabel.frame.origin.x = newX
            }

            return titleView
        }
}
