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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        guard let annot = annotation as? Point else { return nil }
        
        return PointView(
            annotation: annotation,
            reuseIdentifier: annot.groupId.title,
            type: annot.groupId
        )
        
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
        guard let type: DashboardButton = DashboardButton(rawValue: cell.subtitle.text?.lowercased() ?? "") else { return }
        switch type {
            case .lights: getLights()
            case .cameras: getCameras()
            case .taxi: getTaxiRanks()
            case .police: getPoliceStations()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
        
//        guard let cell = collectionView.cellForItem(at: indexPath) as? DashboardCollectionViewCell else { return }
//        guard let type: DashboardButton = DashboardButton(rawValue: cell.title.text?.lowercased() ?? "") else { return }
//        self.removeFromMap(type: type)
    }
    
    // MARK: - Functions
    
    func retrieveAndCacheData() {
        
    }
    
//    func addToMap(type: DashboardButton) {
//        var points: [Point] = [Point]()
//        switch type {
//        case .lights: points = dataValues[DashboardButton.lights.title] ?? getLights()
//        case .cameras: points = dataValues[DashboardButton.cameras.title] ?? getCameras()
//        case .taxi: points = dataValues[DashboardButton.taxi.title] ?? getTaxiRanks()
//        case .police: points = dataValues[DashboardButton.police.title] ?? getPoliceStations()
//        }
//
//        points.forEach { point in
//            self.mapView.addAnnotation(point)
//        }
//    }
    
    func addToMap(points: [Point]) {
        points.forEach { point in
            self.mapView.addAnnotation(point)
        }
    }
    
    func removeFromMap(type: DashboardButton) {
        
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
        let regionRadius: CLLocationDistance = 2500
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
    
    // MARK: - Get API Functions
    
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
    
    func getLights() {
        getFeatureLights()
        getStreetLights()
    }
    
    func getFeatureLights() {
        GetFeatureLights().dispatch(
            onSuccess: { successResponse in
                var pointArray = [Point]()
                successResponse.forEach { light in
                    pointArray.append(Point(
                        groupId: DashboardButton.lights,
                        title: light.assetNumber,
                        subtitle: light.assetDescription,
                        latitude: Double(light.lat) ?? 0.0,
                        longitude: Double(light.lon) ?? 0.0
                    ))
                }
                self.dataValues[DashboardButton.lights.title] = pointArray
                self.addToMap(points: self.dataValues[DashboardButton.lights.title] ?? [Point]())
        },
            onError: { errorResponse, error in
                print("Error on feature lights: \(error.localizedDescription)")
        })
    }
    
    func getStreetLights() {
        GetStreetLights().dispatch(
            onSuccess: { successResponse in
                var pointArray = [Point]()
                successResponse.forEach { light in
                    pointArray.append(Point(
                        groupId: DashboardButton.lights,
                        title: light.name,
                        subtitle: light.assetSubt,
                        latitude: Double(light.theGeom.coordinates[1]),
                        longitude: Double(light.theGeom.coordinates[0])
                    ))
                }
                self.dataValues[DashboardButton.lights.title] = pointArray
                self.addToMap(points: self.dataValues[DashboardButton.lights.title] ?? [Point]())
        },
            onError: { errorResponse, error in
                print("Error on street lights: \(error.localizedDescription)")
        })
    }
    
    func getTaxiRanks() {
        GetTaxiRankLocations().dispatch(
            onSuccess: { successResponse in
                var pointArray = [Point]()
                successResponse.forEach { rank in
                    pointArray.append(Point(
                        groupId: DashboardButton.taxi,
                        title: rank.ref,
                        subtitle: nil,
                        latitude: Double(rank.theGeom.coordinates[1]),
                        longitude: Double(rank.theGeom.coordinates[0])
                    ))
                }
                self.dataValues[DashboardButton.taxi.title] = pointArray
                self.addToMap(points: self.dataValues[DashboardButton.taxi.title] ?? [Point]())
        },
            onError: { errorResponse, error in
                print("Error on taxi ranks: \(error.localizedDescription)")
        })
    }
    
    func getCameras() {
        GetCameras().dispatch(
            onSuccess: { successResponse in
                var pointArray = [Point]()
                successResponse.forEach { camera in
                    pointArray.append(Point(
                        groupId: DashboardButton.cameras,
                        title: camera.name,
                        subtitle: camera.locDesc,
                        latitude: Double(camera.theGeom.coordinates[1]),
                        longitude: Double(camera.theGeom.coordinates[0])
                    ))
                }
                self.dataValues[DashboardButton.cameras.title] = pointArray
                self.addToMap(points: self.dataValues[DashboardButton.cameras.title] ?? [Point]())
        },
            onError: { errorResponse, error in
                print("Error on cameras: \(error.localizedDescription)")
        })
    }
    
    func getPoliceStations() {
        
    }
}
