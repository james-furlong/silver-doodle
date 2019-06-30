//
//  SliderViewController.swift
//  Light up the night
//
//  Created by James Furlong on 26/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    private var searchResults = [SearchResult]()
    
    // MARK: - Initialisation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCollectionView.dataSource = self
        buttonCollectionView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        prepareBackgroundView()
        setCollectionViewPadding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame ?? CGRect(x: 0, y: 0, width: 0, height: 0)
            let yComponent = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        }
    }
    
    // MARK: - Functions
    
    @objc
    func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let y = self.view.frame.minY
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func prepareBackgroundView() {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        let blurredView = UIVisualEffectView(effect: blurEffect)
        blurredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        blurredView.frame = UIScreen.main.bounds
        
        blurredView.layer.cornerRadius = 50
        backgroundView.addSubview(blurredView)
        view.insertSubview(blurredView, at: 0)
    }
    
    func setCollectionViewPadding() {
        let width = buttonCollectionView.frame.width
        let remainingWidth = width - (2.0 *  140.0)
        let padding = remainingWidth / 4
        buttonCollectionView.contentInset = UIEdgeInsets(
            top: padding,
            left: padding,
            bottom: padding,
            right: padding
        )
    }
    
    @IBAction func searchTextFieldChanged(_ sender: UITextField) {
        guard let searchTerm = sender.text else { return }
        guard searchTerm.count >= 3 else { return }
        
//        GetAddressSearchResults(with: searchTerm).dispatch(
//            onSuccess: { searchResults in
//                searchResults.forEach { [weak self] result in
//                    self?.searchResults.append(SearchResult(
//                        streetExtra: nil,
//                        streetNumber: Int(result.streetNo ?? "0") ?? 0 ,
//                        streetName: result.strName,
//                        suburb: result.suburb,
//                        state: "Victoria",
//                        postcode: result.postCode,
//                        country: <#T##String#>)
//                    )
//                }
//        },
//            onError: { errorResponse, error in
//
//        })
    }
    
    // MARK: - CollectionView functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DashboardButton.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as? SliderButtonCollectionViewCell else { return UICollectionViewCell() }
        
        let button = DashboardButton.allCases[indexPath.row]
        cell.updateCell(with: button)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let button = DashboardButton.allCases[indexPath.row]
        guard let parent = self.parent as? DashboardViewController else { return }
        
        switch button {
            case .taxi: parent.getTaxiRanks()
            case .cameras: parent.getCameras()
            case .lights: parent.getLights()
            case .police: parent.getPoliceStations()
            default: break
        }
    }
    
    // MARK: - TableView functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
