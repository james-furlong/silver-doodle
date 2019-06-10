//
//  UIView+Extensions.swift
//  Light up the night
//
//  Created by James Furlong on 6/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit.UIView

extension UIView {
    /// Function to transfor a UIView into a UIImage
    ///
    /// - Returns: a UIImage type version of the original UIView
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
