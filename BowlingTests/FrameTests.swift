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
    
    func test_whenBothRollArePerformed_thenFrameIsFinished() {
        var frame = Frame(roll1: 1)
        frame.roll2 = 2
        
        XCTAssertTrue(frame.isFinished)
    }
    
    func test_oneRollIsPerformed_thenFrameIsNotFinished() {
        let frame = Frame(roll1: 1)
        
        XCTAssertFalse(frame.isFinished)
    }
}
