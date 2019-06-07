//
//  DashboardViewController.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DashboardViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    var tileRenderer: MKTileOverlayRenderer?
    var dataValues: [String: [Point]] = [String: [Point]]()
    var buttonArray: [DashboardButton] = [DashboardButton]()
    var counterArray = [CounterLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveAndCacheData()
        loadMap()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib.init(nibName: "DashboardCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "DashboardButton"
        )
        
        buttonArray = [.taxi, .police, .cameras, .lights]
        
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - MapView
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return tileRenderer!
    }
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DashboardButton.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardButton", for: indexPath) as? DashboardCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(with: buttonArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? DashboardCollectionViewCell else { return }
        guard let type: DashboardButton = DashboardButton(rawValue: cell.title.text?.lowercased() ?? "") else { return }
        self.addToMap(type: type)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? DashboardCollectionViewCell else { return }
        guard let type: DashboardButton = DashboardButton(rawValue: cell.title.text?.lowercased() ?? "") else { return }
        self.removeFromMap(type: type)
    }
    
    // MARK: - Functions
    
    func retrieveAndCacheData() {
        
    }
    
    func loadMap() {
        let overlay = NightLightOverlay()
        overlay.canReplaceMapContent = true
        mapView.addOverlay(overlay, level: .aboveLabels)
        tileRenderer = MKTileOverlayRenderer(tileOverlay: overlay)
        
        let initialLocation = locationManager.location
        centerMapOnLocation(location: initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation?) {
        let regionRadius: CLLocationDistance = 1000
        guard let location = location else { return }
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func getCounterLocations() {
        GetPedestrianCounterLocations().dispatch(
            onSuccess: { successResponse in
                successResponse.forEach { location in
                    self.counterArray.append(CounterLocation(
                        latitude: Double(location.latitude) ?? 0.0,
                        longitude: Double(location.longitude) ?? 0.0,
                        id: location.sensorID,
                        title: location.sensorName,
                        count: nil
                    ))
                }
        },
            onFailure: { errorResponse, error in
                print("Error on counter locations: \(error.localizedDescription)")
        })
    }
    
    func getCounterStats() {
        GetPedestrianCount().dispatch(
            onSuccess: { successResponse in
                successResponse.forEach { counter in
                    for location in self.counterArray where location.id == counter.sensorID {
                        location.count = Int(counter.totalOfDirections)
                    }
                }
        },
            onError: { errorResponse, error in
                print("Error on counter data: \(error.localizedDescription)")
        })
    }
    
    func getFeatureLights() {
        
    }
}
