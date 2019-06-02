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
        
        let locations = getSensorLocations()
//        addLocationsToMap(with: locations)
        
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
    
    func getSensorLocations() -> [PedestrianCounter] {
        var locationArray: [PedestrianCounter] = [PedestrianCounter]()
        
        GetPedestrianCounterLocations()
            .dispatch(
                onSuccess: { successResponse in
                    self.addLocationsToMap(with: successResponse)
                    locationArray = successResponse
            },
                onFailure: { errorResponse, error in
                    print(error.localizedDescription)
            })
        
        return locationArray
    }
    
    func addLocationsToMap(with data: [PedestrianCounter]) {
        for counter in data {
            let lat = Double(counter.latitude) ?? 0.00
            let long = Double(counter.longitude) ?? 0.00
            let location = CLLocationCoordinate2DMake(lat, long)
            mapView.addAnnotation(
                PedestrianCounterAnnotation(
                    title: counter.sensorName,
                    locationDescription: counter.sensorDescription,
                    coordinate: location
                )
            )
        }
    }
}
