//
//  Game.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/19/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class Game {
    weak var delegate: GameDelegate?
    
    var employees: [Employee] = []
    var currentQuestion: [Employee] = []
    var correctAnswerIndex: Int = 0
    
    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    
    func selectNewEmployees() {
        //Clear current question & select 6 new employees
        currentQuestion.removeAll()
        employees.shuffle()
        for i in 0...5 {
            currentQuestion.append(employees[i])
        }
        
        //Select correct answer
        correctAnswerIndex = Int.random(in: 0...5)
    }
    
    func selectedCorrectAnswer() {
        correctAnswers += 1
        delegate?.newQuestion()
    }
    
    func selectedIncorrectAnswer() {
        incorrectAnswers += 1
    }
    
    func correctAnswerEquals(_ indexPath: Int) -> Bool {
        return indexPath == correctAnswerIndex
    }
}

protocol GameDelegate: class {
    func newQuestion()
    func endGame(correctAnswers:Int, incorrectAnswers:Int)
}
