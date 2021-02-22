//
//  PracticeModeGame.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/19/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class PracticeModeGame: Game {
    
    override func selectedIncorrectAnswer() {
        super.selectedIncorrectAnswer()
        delegate?.endGame(correctAnswers: correctAnswers, incorrectAnswers: incorrectAnswers)
    }
}
