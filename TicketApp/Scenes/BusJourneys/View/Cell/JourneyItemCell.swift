//
//  JourneyItemCell.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import UIKit

final class JourneyItemCell: UICollectionViewCell {
    @IBOutlet private weak var lblArriveTime: UILabel!
    @IBOutlet private weak var lblDepartureTime: UILabel!
    @IBOutlet private weak var lblAmount: UILabel!
    @IBOutlet private weak var lblDestination: UILabel!
    
    // Set cell data based on a JourneyItemDataModel
    func setCellData(model: JourneyItemDataModel) {
        lblDepartureTime.text = model.departureTime
        lblArriveTime.text = model.arrivalTime
        lblDestination.text = model.fullDestination
        lblAmount.text = model.amountStr
    }
}
