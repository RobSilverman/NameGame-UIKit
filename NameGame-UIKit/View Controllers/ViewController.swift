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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        practiceModeButton.layer.cornerRadius = 10
        timedModeButton.layer.cornerRadius = 10
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        targetImage.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        practiceModeButton.translatesAutoresizingMaskIntoConstraints = false
        timedModeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            navigationController?.setNavigationBarHidden(true, animated: false)
        }

}

