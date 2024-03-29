//
//  File.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

enum DashboardButton: CaseIterable {
    case taxi
    case police
    case cameras
    case lights
    case ptv
    case settings
        
    var backgroundColor: UIColor {
        switch self {
            case .taxi: return #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            case .police: return #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            case .cameras: return #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
            case .lights: return #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            case .ptv: return #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            case .settings: return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    var tintColor: UIColor {
        switch self {
            case .taxi, .lights: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            default: return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    var title: String {
        switch self {
            case .taxi: return "Taxi"
            case .police: return "Police"
            case .cameras: return "Camera"
            case .lights: return "Lights"
            case .ptv: return "PTV"
            case .settings: return "Settings"
        }
    }
    
    var subtitle: String {
        switch self {
            case .taxi: return "Rank locations"
            case .police: return "24hr stations"
            case .cameras: return "Safe-City"
            case .ptv: return "Locations"
            default: return ""
        }
    }
}
