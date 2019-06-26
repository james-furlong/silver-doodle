//
//  SliderViewController.swift
//  Light up the night
//
//  Created by James Furlong on 26/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCollectionView.dataSource = self
        buttonCollectionView.delegate = self
        
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
}
