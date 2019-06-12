//
//  AddressSearchTableViewCell.swift
//  Light up the night
//
//  Created by James Furlong on 9/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

class AddressSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var goImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Function to update the cell UI elements
    ///
    /// - Parameter address: The address to update the cell with
    func updateCell(with address: AddressSearchResponseElement) {
        titleLabel.text = address.addressPnt
    }
}
