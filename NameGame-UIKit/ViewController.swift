//
//  ViewController.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/18/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var targetImage: UIImageView!
    @IBOutlet var instructionLabel: UILabel!
    @IBOutlet var practiceModeButton: UIButton!
    @IBOutlet var timedModeButton: UIButton!
    
    var portraitConstraints: [NSLayoutConstraint] {[
        targetImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        targetImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -50),
        targetImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50),
        targetImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 71),
        
        logoImage.centerXAnchor.constraint(equalTo: targetImage.centerXAnchor),
        logoImage.centerYAnchor.constraint(equalTo: targetImage.centerYAnchor),
        logoImage.heightAnchor.constraint(equalTo: targetImage.heightAnchor, multiplier: 0.67),
        logoImage.widthAnchor.constraint(equalTo: targetImage.widthAnchor, multiplier: 0.67),
        
        timedModeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        timedModeButton.heightAnchor.constraint(equalToConstant: 56),
        timedModeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
        timedModeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        timedModeButton.widthAnchor.constraint(lessThanOrEqualToConstant: 433),
        
        practiceModeButton.bottomAnchor.constraint(equalTo: timedModeButton.topAnchor, constant: -8),
        practiceModeButton.heightAnchor.constraint(equalTo: timedModeButton.heightAnchor),
        practiceModeButton.widthAnchor.constraint(equalTo: timedModeButton.widthAnchor),
        practiceModeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
        
        instructionLabel.bottomAnchor.constraint(equalTo: practiceModeButton.topAnchor, constant: -55),
        instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47),
        instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -47)
    ]}
    
    var landscapeConstraints: [NSLayoutConstraint] {[
        targetImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -50),
        targetImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
        targetImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
        targetImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width * -0.5),
        
        logoImage.centerXAnchor.constraint(equalTo: targetImage.centerXAnchor),
        logoImage.centerYAnchor.constraint(equalTo: targetImage.centerYAnchor),
        logoImage.heightAnchor.constraint(equalTo: targetImage.heightAnchor, multiplier: 0.67),
        logoImage.widthAnchor.constraint(equalTo: targetImage.widthAnchor, multiplier: 0.67),
        
        timedModeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        timedModeButton.heightAnchor.constraint(equalToConstant: 56),
        timedModeButton.widthAnchor.constraint(equalToConstant: 359),
        timedModeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -64),
        
        practiceModeButton.bottomAnchor.constraint(equalTo: timedModeButton.topAnchor, constant: -8),
        practiceModeButton.heightAnchor.constraint(equalTo: timedModeButton.heightAnchor),
        practiceModeButton.widthAnchor.constraint(equalTo: timedModeButton.widthAnchor),
        practiceModeButton.trailingAnchor.constraint(equalTo: timedModeButton.trailingAnchor),
        
        instructionLabel.bottomAnchor.constraint(equalTo: practiceModeButton.topAnchor, constant: -55),
        instructionLabel.widthAnchor.constraint(equalToConstant: 281)
    ]}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        practiceModeButton.layer.cornerRadius = 10
        timedModeButton.layer.cornerRadius = 10
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        targetImage.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        practiceModeButton.translatesAutoresizingMaskIntoConstraints = false
        timedModeButton.translatesAutoresizingMaskIntoConstraints = false
        
        layoutViews(UIDevice.current.orientation)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let deviceOrientation = UIDevice.current.orientation
        layoutViews(deviceOrientation)
    }
    
    func layoutViews(_ orientation: UIDeviceOrientation) {
        if orientation.isLandscape {
            //Deactivate portrait layout constraints, then activate landscape
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        } else {
            //Deactivate landscape layout constraints, then activate portrait
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        }
        view.layoutSubviews()
    }

}

