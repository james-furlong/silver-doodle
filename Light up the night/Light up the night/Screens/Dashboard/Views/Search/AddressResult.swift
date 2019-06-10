//
//  AddressResult.swift
//  Light up the night
//
//  Created by James Furlong on 10/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

class AddressResult: UIView {

    // MARK: - UI
    
    private let addressLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    // MARK: Initialization
    
    init(address: String) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .white
        addressLabel.text = address
        
        self.addSubview(addressLabel)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error on AddressResult")
    }
    
    // MARK: - Layout
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            addressLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            addressLabel.heightAnchor.constraint(equalToConstant: 50),
            addressLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
