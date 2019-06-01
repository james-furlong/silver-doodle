//
//  ViewController.swift
//  Light up the night
//
//  Created by James Furlong on 2/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        loadMap()
    }
    
    func loadMap() {
        let initialLocation = locationManager.location
        centerMapOnLocation(location: initialLocation)
    }

    
    func centerMapOnLocation(location: CLLocation?) {
        let regionRadius: CLLocationDistance = 1000
        guard let location = location else { return }
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

