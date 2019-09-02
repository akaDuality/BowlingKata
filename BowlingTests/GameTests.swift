//
//  GameTests.swift
//  BowlingTests
//
//  Created by Mikhail Rubanov on 02/09/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import XCTest
@testable import Bowling

class GameTests: XCTestCase {
    
    func test_initialScoreIsZero() {
        XCTAssertEqual(0, game.score)
    }
    
    func test_whenRollIsPerformed_thenScoreEqualToHatPins() {
        game.roll(5)
        
        XCTAssertEqual(5, game.score)
    }
    
    func test_whenTwoRollsArePerformed_scoreIsEqualToSumm() {
        game.roll(5)
        game.roll(4)
        
        XCTAssertEqual(9, game.score)
    }
    
    private var game: Game!
    override func setUp() {
        game = Game()
    }
    
    override func tearDown() {
        game = nil
    }
}
