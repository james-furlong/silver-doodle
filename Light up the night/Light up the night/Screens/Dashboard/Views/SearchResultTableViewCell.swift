//
//  SearchResultTableViewCell.swift
//  Light up the night
//
//  Created by James Furlong on 27/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func updateCell(with result: SearchResult) {
        self.titleLabel.text = result.fullAddress
    }

}
