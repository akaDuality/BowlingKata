//
//  FrameTests.swift
//  BowlingTests
//
//  Created by Mikhail Rubanov on 02/09/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import XCTest
@testable import Bowling

class FrameTests: XCTestCase {

    // MARK: - Rolls
    func test_frameContainsTwoRolls() {
        var frame = Frame(roll1: 1)
        frame.roll2 = 2
        
        XCTAssertEqual(1, frame.roll1)
        XCTAssertEqual(2, frame.roll2)
    }
    
    func test_2ndRollIsOptional() {
        let frame = Frame(roll1: 1)
        
        XCTAssertNil(frame.roll2)
    }
    
    // MARK: - Frame ending
    func test_whenBothRollArePerformed_thenFrameIsFinished() {
        var frame = Frame(roll1: 1)
        frame.roll2 = 2
        
        XCTAssertTrue(frame.isFinished)
    }
    
    func test_oneRollIsPerformed_thenFrameIsNotFinished() {
        let frame = Frame(roll1: 1)
        
        XCTAssertFalse(frame.isFinished)
    }
    
    // MARK: - Spare
    func test_whenBothRollesScore10Points_thenItIsSpare() {
        var frame = Frame(roll1: 4)
        frame.roll2 = 6
        
        XCTAssertTrue(frame.isSpare)
    }
    
    // MARK: - Strike
    func test_when1stRollIs10_thenIsIsStrike() {
        let frame = Frame(roll1: 10)
        
        XCTAssertTrue(frame.isStrike)
    }
    
    func test_whenStrike_thenFrameIsFinished() {
        let frame = Frame(roll1: 10)
        
        XCTAssertTrue(frame.isFinished)
    }
    
    // MARK: - Frame score
    func test_frameScoreIsSummOfBothRolls() {
        var frame = Frame(roll1: 2)
        frame.roll2 = 4
        
        XCTAssertEqual(6, frame.score)
    }
    
    func test_canNotRoll2ndTimeAfterStrike() {
        var frame = Frame(roll1: 10)
        frame.roll2 = 4
        
        XCTAssertEqual(10, frame.score)
    }
}
