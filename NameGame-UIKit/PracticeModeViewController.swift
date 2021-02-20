//
//  PracticeMode.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/18/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class PracticeModeViewController: UIViewController, GameDelegate, UICollectionViewDelegate {
    
    var practiceModeGame = PracticeModeGame()
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        practiceModeGame.delegate = self
        collectionView.delegate = self
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        API.getEmployees { (data, error) in
            guard let data = data, error == nil else {
                //Present error alert, incl. pop to home view
                return
            }
            self.practiceModeGame.employees += data
            DispatchQueue.main.async {
                self.newQuestion()
            }
        }
    }
    
    func newQuestion() {
        practiceModeGame.selectNewEmployees()
        nameLabel.text = practiceModeGame.currentQuestion[practiceModeGame.correctAnswerIndex].fullName
        collectionView.reloadData()
    }
    
}
