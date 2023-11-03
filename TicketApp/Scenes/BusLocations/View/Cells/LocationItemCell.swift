//
//  LocationItemCell.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import UIKit

final class LocationItemCell: UICollectionViewCell {
    
    @IBOutlet weak var lblLocationTitle: UILabel!
    
    func setCellData(model: LocationItemDataModel) {
        lblLocationTitle.text = model.name
    }
}
