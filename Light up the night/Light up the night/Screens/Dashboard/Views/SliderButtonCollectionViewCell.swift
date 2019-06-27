//
//  SliderButtonCollectionViewCell.swift
//  Light up the night
//
//  Created by James Furlong on 26/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

class SliderButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var buttonImageView: UIImageView!
    
    func updateCell(with button: DashboardButton) {
        titleLabel.text = button.title
        subtitleLabel.text = button.subtitle
        self.backgroundColor = button.backgroundColor
        titleLabel.textColor = button.tintColor
        subtitleLabel.textColor = button.tintColor
        // TODO: Add icons when assests are complete
    }
}
