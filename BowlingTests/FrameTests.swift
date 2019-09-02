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
        let frame = Frame(roll1: 1, roll2: 2)
        
        XCTAssertEqual(1, frame.roll1)
        XCTAssertEqual(2, frame.roll2)
    }
}
