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
    
    private func spare(first: Int) {
        game.roll(first)
        game.roll(10-first)
    }
    
    private var game: Game!
    override func setUp() {
        game = Game()
    }
    
    override func tearDown() {
        game = nil
    }
}
