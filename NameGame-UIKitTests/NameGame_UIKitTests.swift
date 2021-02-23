//
//  NameGame_UIKitTests.swift
//  NameGame-UIKitTests
//
//  Created by Robert Silverman on 2/18/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import XCTest
@testable import NameGame_UIKit

class NameGame_UIKitTests: XCTestCase {
    
    var game: Game?

    override func setUp() {
        game = Game()
    }

    override func tearDown() {
        game = nil
    }
    
    func testCorrectAnswerEquating() {
        game?.correctAnswerIndex = 3
        XCTAssertTrue(game!.correctAnswerEquals(3))
    }

    func testInitialData() {
        XCTAssertEqual(game?.correctAnswers, 0)
        XCTAssertEqual(game?.incorrectAnswers, 0)
    }
    
    func testSelectedCorrect() {
        game?.selectedCorrectAnswer()
        XCTAssertEqual(game?.correctAnswers, 1)
        XCTAssertEqual(game?.incorrectAnswers, 0)
        
        game?.selectedCorrectAnswer()
        game?.selectedCorrectAnswer()
        XCTAssertEqual(game?.correctAnswers, 3)
        XCTAssertEqual(game?.incorrectAnswers, 0)
    }
    
    func testSelectedIncorrect() {
        game?.selectedIncorrectAnswer()
        XCTAssertEqual(game?.correctAnswers, 0)
        XCTAssertEqual(game?.incorrectAnswers, 1)
        
        game?.selectedIncorrectAnswer()
        game?.selectedIncorrectAnswer()
        XCTAssertEqual(game?.correctAnswers, 0)
        XCTAssertEqual(game?.incorrectAnswers, 3)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
