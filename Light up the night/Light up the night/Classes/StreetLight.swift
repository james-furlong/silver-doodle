//
//  StreetLight.swift
//  Light up the night
//
//  Created by James Furlong on 6/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import MapKit

class StreetLight: MKAnnotationView {
    
    private let color: UIColor = #colorLiteral(red: 0.9861351848, green: 1, blue: 0, alpha: 1)
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let imageView: UIView = {
            let view: UIView = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = color
            view.frame.size = CGSize(
                width: StreetLight.maxSize,
                height: StreetLight.maxSize
            )
            view.layer.cornerRadius = StreetLight.maxSize / 2
           
            return view
        }()
        
        self.image = imageView.asImage()
        self.canShowCallout = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false
        print("Required init failed")
    }
}