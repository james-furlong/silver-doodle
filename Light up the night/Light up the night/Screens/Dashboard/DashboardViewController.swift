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
    var buttonArray: [DashboardButton] = [DashboardButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return tileRenderer!
    }
}
