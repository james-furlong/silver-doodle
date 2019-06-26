//
//  SliderViewController.swift
//  Light up the night
//
//  Created by James Furlong on 26/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
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
        
        view.layer.cornerRadius = 10
        view.insertSubview(blurredView, at: 0)
    }
}
