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
    
    init() {
        
    }
    
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
}

protocol GameDelegate: class {
    func newQuestion()
}
