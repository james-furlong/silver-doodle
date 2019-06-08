//
//  Point.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import MapKit

class PointView: MKAnnotationView {
    
    private static let maxSize: CGFloat = 4.0
    
    init(annotation: MKAnnotation?, reuseIdentifier: String?, type: DashboardButton) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let imageView: UIView = {
            let view: UIView = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = type.backgroundColor
            view.frame.size = CGSize(
                width: PointView.maxSize,
                height: PointView.maxSize
            )
            view.layer.cornerRadius = PointView.maxSize / 2
            
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
