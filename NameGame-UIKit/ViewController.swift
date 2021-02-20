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
    
    let portraitConstraints: [NSLayoutConstraint] = [
        
    ]
    
    let landscapeConstraints: [NSLayoutConstraint] = [
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        practiceModeButton.layer.cornerRadius = 10
        timedModeButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let deviceOrientation = size.width > size.height ? UIDeviceOrientation.landscapeLeft : UIDeviceOrientation.portrait
        layoutViews(deviceOrientation)
    }
    
    func layoutViews(_ orientation: UIDeviceOrientation) {
        if orientation == .landscapeLeft {
            //Deactivate portrait layout constraints, then activate landscape
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        } else {
            //Deactivate landscape layout constraints, then activate portrait
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        }
    }

}

