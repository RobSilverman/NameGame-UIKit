//
//  TimedMode.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/18/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class TimedModeViewController: UIViewController, GameDelegate {
    
    var imageSize = CGSize(width: 0, height: 0)
    
    var timedModeGame = TimedModeGame()
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var timerView: TimerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timedModeGame.delegate = self
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
            self.timedModeGame.employees += data
            DispatchQueue.main.async {
                self.newQuestion()
            }
        }
    }
    
    func newQuestion() {
        timedModeGame.selectNewEmployees()
        nameLabel.text = timedModeGame.currentQuestion[timedModeGame.correctAnswerIndex].fullName
        collectionView.reloadData()
        collectionView.visibleCells.forEach({$0.isUserInteractionEnabled = true})
    }
    
    func endGame(correctAnswers: Int, incorrectAnswers: Int) {
        let ac = UIAlertController(title: "Game Over", message: "Scored \(timedModeGame.correctAnswers)/\(timedModeGame.correctAnswers + timedModeGame.incorrectAnswers)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(ac, animated: true)
    }
    
    func redrawCircle(proportionComplete: Double) {
        timerView.currentProgress = proportionComplete
        timerView.setNeedsDisplay()
    }
    
}

extension TimedModeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timedModeGame.currentQuestion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PracticeCell", for: indexPath) as! EmployeeCell
        let employee = timedModeGame.currentQuestion[indexPath.row]
        cell.getImage(from: employee.headshot.url!, for: imageSize)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if timedModeGame.correctAnswerEquals(indexPath.row) {
            //Deactivate all cells, animate correct overlay, add to score and start new question
            collectionView.visibleCells.forEach({ $0.isUserInteractionEnabled = false })
            let cell = collectionView.cellForItem(at: indexPath) as! EmployeeCell
            UIView.animate(withDuration: 1, animations: cell.addCorrectOverlay) { _ in
                collectionView.visibleCells.forEach({ $0.isUserInteractionEnabled = true })
                self.timedModeGame.selectedCorrectAnswer()
            }

        } else {
            //Deactivate cell, animate incorrect overlay, add to incorrect answers then end game
            let cell = collectionView.cellForItem(at: indexPath) as! EmployeeCell
            cell.isUserInteractionEnabled = false
            UIView.animate(withDuration: 1, animations: cell.addIncorrectOverlay) { _ in
                self.timedModeGame.selectedIncorrectAnswer()
            }
        }
    }
}

extension TimedModeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = UIDevice.current.orientation.isLandscape ? (collectionView.bounds.height / 2) - 50 : (collectionView.bounds.width / 2) - 30
        imageSize = CGSize(width: dimension, height: dimension)
        return imageSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if UIDevice.current.orientation.isLandscape {
            return UIEdgeInsets(top: 15, left: 24, bottom: 15, right: 105)
        } else {
            return UIEdgeInsets(top: 24, left: 15, bottom: 105, right: 15)
        }
    }
    
}
