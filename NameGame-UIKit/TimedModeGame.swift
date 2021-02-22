//
//  TimedModeGame.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/22/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class TimedModeGame: Game {
    
    var timeElapsed: Float = 0
    var gameLength: Float = 60
    
    var timer: Timer?
    
    override init() {
        super.init()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTicks), userInfo: nil, repeats: true)
    }
    
    @objc func timerTicks() {
        timeElapsed += 1
        delegate?.redrawCircle(proportionComplete: Double(timeElapsed / gameLength))
        if timeElapsed >= gameLength {
            timer?.invalidate()
            delegate?.endGame(correctAnswers: correctAnswers, incorrectAnswers: incorrectAnswers)
        }
    }
}
