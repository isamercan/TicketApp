//
//  InfoCell.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import UIKit

final class InfoCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func setup(title: String) {
        titleLabel.text = title
    }

}
