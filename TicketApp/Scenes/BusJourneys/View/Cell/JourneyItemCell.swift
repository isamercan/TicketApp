//
//  JourneyItemCell.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//

import UIKit

final class JourneyItemCell: UICollectionViewCell {

    @IBOutlet weak var lblArriveTime: UILabel!
    @IBOutlet weak var lblDepartureTime: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    
    func setCellData(model: JourneyItemDataModel) {
        lblDepartureTime.text = model.departureTime
        lblArriveTime.text = model.arrivalTime
        lblDestination.text = model.fullDestination
        lblAmount.text = model.amountStr
    }
}
