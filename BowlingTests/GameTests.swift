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
    
    // MARK: - Spare
    func test_whenTwoRollesAre10InSum_isSpare_thenNextRollScoredTwice() {
        spare(first: 4)
        
        game.roll(6)
        
        XCTAssertEqual(22, game.score)
    }
    
    func test_twoSparesInRow_summsRight() {
        spare(first: 4)
        spare(first: 6)
        
        game.roll(2)
        
        XCTAssertEqual(22 + 6 + 2, game.score)
    }
    
    func test_twoEqualSparesInRow_notInterfere() {
        spare(first: 4)
        spare(first: 4)
        
        game.roll(2)
        
        XCTAssertEqual(22 + 4 + 2, game.score)
    }
    
    // MARK: - Strike
    func test_whenStike_thenNextTwoRollsScoredTwice() {
        strike()
        
        game.roll(4)
        game.roll(2)
        
        XCTAssertEqual(16 + 4 + 2, game.score)
    }
    
    func test_when3StrikeInARow_FirstRollScores30Points_and2ndRollScored20Points() {
        strike()
        strike()
        strike()
        
        XCTAssertEqual(30 + 20 + 10, game.score)
    }
    
    func test_whenLastRollIsStrike_gameWaitsForAdditionalRoll() {
        roll(1, times: 18)
        strike()
        
        XCTAssertFalse(game.isFinished)
        game.roll(10)
        XCTAssertTrue(game.isFinished)
    }

    // MARK: Game ending
    func test_whenGameIsStarted_isNotFinished() {
        XCTAssertFalse(game.isFinished)
    }
    
    func test_when20RegularRollsArePerformed_gameIsFinished() {
        roll(1, times: 20)
        
        XCTAssertTrue(game.isFinished)
    }
    
    func test_when19RegularRollsArePerformed_gameIsNotFinished() {
        roll(1, times: 19)
        
        XCTAssertFalse(game.isFinished)
    }
    
    func test_when20RegularRollsArePerformed_newRollDoesNotAffectScore() {
        roll(1, times: 20) // Game ends here
        
        game.roll(1)
        
        XCTAssertEqual(20, game.score)
    }
    
    func test_whenLastRollIsStrike_additionalRollIsAllowed() {
        roll(1, times: 18) // Game ends here
        strike()
        game.roll(4)
        
        XCTAssertEqual(18 + 10 + 4, game.score)
    }
    
    func test_whenLastRollIsSpare_additionalRollIsAllowed() {
        roll(1, times: 18) // Game ends here
        spare()
        game.roll(4)
        
        XCTAssertEqual(18 + 10 + 4, game.score)
    }
    
    func test_whenAllRollsAreStrike_thenMaxScore() {
        roll(10, times: 11)

        XCTAssertTrue(game.isFinished)
        XCTAssertEqual(300, game.score)
    }

    // MARK: - DSL
    private func strike() {
        game.roll(10)
    }
    
    private func spare(first: Int = 4) {
        game.roll(first)
        game.roll(10-first)
    }
    
    private func roll(_ pins: Int, times: Int) {
        for _ in 0..<times {
            game.roll(pins)
        }
    }
    
    // MARK: - Setup
    private var game: Game!
    override func setUp() {
        game = Game()
    }
    
    override func tearDown() {
        game = nil
    }
}
