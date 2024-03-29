//
//  DashboardCollectionViewCell.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Func to set up the collection view cell with a button
    ///
    /// - Parameter button: A DashboardButton type that will be used to setup the cell
    public func setupCell(with button: DashboardButton) {
        self.background.backgroundColor = button.backgroundColor
        self.title.text = button.title
        self.subtitle.text = button.subtitle
    }

}
