//
//  PracticeMode.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/18/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class PracticeModeViewController: UIViewController, GameDelegate {
    
    var imageSize = CGSize(width: 0, height: 0)
    
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
        collectionView.visibleCells.forEach({$0.isUserInteractionEnabled = true})
    }
    
    func endGame(correctAnswers: Int, incorrectAnswers: Int) {
        let ac = UIAlertController(title: "Game Over", message: "Scored \(practiceModeGame.correctAnswers)/\(practiceModeGame.correctAnswers + practiceModeGame.incorrectAnswers)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(ac, animated: true)
    }
    
}

extension PracticeModeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return practiceModeGame.currentQuestion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PracticeCell", for: indexPath) as! EmployeeCell
        let employee = practiceModeGame.currentQuestion[indexPath.row]
        cell.getImage(from: employee.headshot.url!, for: imageSize)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if practiceModeGame.correctAnswerEquals(indexPath.row) {
            //Deactivate all cells, animate correct overlay, add to score and start new question
            collectionView.visibleCells.forEach({ $0.isUserInteractionEnabled = false })
            let cell = collectionView.cellForItem(at: indexPath) as! EmployeeCell
            UIView.animate(withDuration: 1, animations: cell.addCorrectOverlay) { _ in
                collectionView.visibleCells.forEach({ $0.isUserInteractionEnabled = true })
                self.practiceModeGame.selectedCorrectAnswer()
            }

        } else {
            //Deactivate cell, animate incorrect overlay, add to incorrect answers then end game
            let cell = collectionView.cellForItem(at: indexPath) as! EmployeeCell
            cell.isUserInteractionEnabled = false
            UIView.animate(withDuration: 1, animations: cell.addIncorrectOverlay) { _ in
                self.practiceModeGame.selectedIncorrectAnswer()
            }
        }
    }
}

extension PracticeModeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //TODO: Make flexible for rotating screen
        let sectionInsets = UIEdgeInsets(top: 24, left: 15, bottom: 105, right: 15)
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowLayout?.minimumInteritemSpacing ?? 0.0) + sectionInsets.left + sectionInsets.right
        let cellViewSize = (collectionView.frame.size.width - space) / 2.0
        imageSize = CGSize(width: cellViewSize, height: cellViewSize)
        return imageSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if UIDevice.current.orientation.isLandscape {
            return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
    }
    
}
