//
//  PracticeMode.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/18/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class PracticeModeViewController: UIViewController, GameDelegate {
    
    var practiceModeGame = PracticeModeGame()
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        practiceModeGame.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        API.getEmployees { (data, error) in
            guard let data = data, error == nil else {
                let ac = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(ac, animated: true)
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

extension PracticeModeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return practiceModeGame.currentQuestion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PracticeCell", for: indexPath) as! EmployeeCell
        let employee = practiceModeGame.currentQuestion[indexPath.row]
        cell.getImage(from: employee.headshot.url!)

        return cell
    }
}

extension PracticeModeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //TODO: Make flexible for rotating screen
        let sectionInsets = UIEdgeInsets(top: 24, left: 15, bottom: 105, right: 15)
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowLayout?.minimumInteritemSpacing ?? 0.0) + sectionInsets.left + sectionInsets.right
        let cellViewSize = (collectionView.frame.size.width - space) / 2.0
        let imageSize = CGSize(width: cellViewSize, height: cellViewSize)
        return imageSize
    }
    
}
