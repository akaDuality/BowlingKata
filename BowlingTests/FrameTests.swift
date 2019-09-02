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
    
    func test_1stRoll_isLimitedBy10() {
        let frame = Frame(roll1: 15)
        
        XCTAssertEqual(10, frame.roll1)
    }
    
    func test_2ndRoll_isLimitedByTotal10() {
        var frame = Frame(roll1: 6)
        frame.roll2 = 5
        
        XCTAssertEqual(4, frame.roll2)
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
    
    // MARK: - Frame score
    func test_frameScoreIsSummOfBothRolls() {
        var frame = Frame(roll1: 2)
        frame.roll2 = 4
        
        XCTAssertEqual(6, frame.score)
    }
}

class FrameStrikeTest: XCTestCase {
    
    var frame: Frame!
    
    override func setUp() {
        frame = Frame(roll1: 10)
    }
    
    func test_when1stRollIs10_thenIsIsStrike() {
        XCTAssertTrue(frame.isStrike)
    }
    
    func test_thenFrameIsFinished() {
        XCTAssertTrue(frame.isFinished)
    }
    
    func test_canNotRoll2ndTime() {
        frame.roll2 = 4
        
        XCTAssertEqual(10, frame.score)
    }
    
    func test_spareIsFalse() {
        XCTAssertFalse(frame.isSpare)
    }
}
