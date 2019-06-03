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
        
        getSensorLocations()
        
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
    
    func getSensorLocations() {
        GetPedestrianCounterLocations()
            .dispatch(
                onSuccess: { successResponse in
                    self.getSensorFigures(with: successResponse)
            },
                onFailure: { errorResponse, error in
                    print(error.localizedDescription)
            })
    }
    
    func addLocationsToMap(with data: [PedestrianCounter]) {
        data.forEach { counter in
            mapView.addAnnotation(counter.location)
        }
    }
    
    func createCounters(from locations: PedestrianCounterLocationResponse, and data: PedestrianCounterResponse) -> [PedestrianCounter]{
        var counterArray = [PedestrianCounter]()
        
        locations.forEach { location in
            guard let stats = data.first(where: { $0.sensorID == location.sensorID }) else { return }
            let counter = PedestrianCounter(location: location, counter: stats)
            counterArray.append(counter)
        }
        return counterArray
    }
    
    func getSensorFigures(with data: PedestrianCounterLocationResponse) {
        GetPedestrianCount()
            .dispatch(
                onSuccess: { successResponse in
                    let counters = self.createCounters(from: data, and: successResponse)
                    self.addLocationsToMap(with: counters)
            },
                onError: { errorResponse, error in
                    print(error.localizedDescription)
            })
    }
}