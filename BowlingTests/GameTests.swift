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
    
    
    
    
    private var game: Game!
    override func setUp() {
        game = Game()
    }
    
    override func tearDown() {
        game = nil
    }
}
