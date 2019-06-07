//
//  NightLightOverlay.swift
//  Light up the night
//
//  Created by James Furlong on 5/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import MapKit

class NightLightOverlay: MKTileOverlay {
    
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        let subdomain = "a"
        let style = "dark_all"
        let tileUrl = "https://\(subdomain).basemaps.cartocdn.com/\(style)/\(path.z)/\(path.x)/\(path.y).png"
        return URL(string: tileUrl)!
    }
}
