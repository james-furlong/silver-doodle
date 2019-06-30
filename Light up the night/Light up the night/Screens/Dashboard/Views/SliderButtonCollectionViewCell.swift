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
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var buttonImageView: UIImageView!
    
    func updateCell(with button: DashboardButton) {
        titleLabel.text = button.title
        circleView.backgroundColor = button.backgroundColor
        titleLabel.textColor = .white
        // TODO: Add icons when assests are complete
    }
}
