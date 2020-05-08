//
//  FrameTests.swift
//  BowlingTests
//
//  Created by Mikhail Rubanov on 02/09/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import XCTest
@testable import Bowling

import Quick

class FrameSpec: QuickSpec {
    override func spec() {
        describe("frame") {
            var frame: Frame!
            beforeEach {
                frame = Frame(roll1: 4)
            }

            context("starts from one roll") {
                it("save 1st roll") {
                    XCTAssertEqual(frame.roll1, 4)
                }
                
                it("2nd roll is nil") {
                    XCTAssertNil(frame.roll2)
                }
                
                it("is not finished") {
                    XCTAssertFalse(frame.isFinished)
                }
            }
            
            context("when roll 2nd time") {
                beforeEach {
                    frame.roll2 = 3
                }
                
                it("has 2nd roll") {
                    XCTAssertEqual(frame.roll2, 3)
                }
                
                it("score is summ of two rolls") {
                    XCTAssertEqual(frame.score, 7)
                }
                
                it("frame is finished") {
                    XCTAssertTrue(frame.isFinished)
                }
                
                it("is not spare") {
                    XCTAssertFalse(frame.isSpare)
                }
            }
            
            context("when sum of two rolls more than 10") {
                beforeEach {
                    frame.roll2 = 10
                }
                
                it("should limit by 10") {
                    XCTAssertEqual(frame.score, 10)
                }
            }
        }
        
        describe("spare") {
            var frame: Frame!
            beforeEach {
                frame = Frame(roll1: 4)
            }
            
            context("starts from one roll") {
                it("is not a strike") {
                    XCTAssertFalse(frame.isStrike)
                }
            }
            
            
            context("when 2nd roll hit all elapsed pins") {
                beforeEach {
                    frame.roll2 = 6
                }
                
                it("is spare") {
                    XCTAssertTrue(frame.isSpare)
                }
            }
        }
        
        describe("strike") {
            context("when all pins is hit by 1st roll") {
                let frame = Frame(roll1: 10)
                
                it("is strike") {
                    XCTAssertTrue(frame.isStrike)
                }
                
                it("finishes frame") {
                    XCTAssertTrue(frame.isFinished)
                }
                
                it("not a spare") {
                    XCTAssertFalse(frame.isSpare)
                }
                
                context("when roll 2nd time") {
                    it("score is stay 10") {
                        XCTAssertEqual(frame.score, 10)
                    }
                    
                    it("2nd roll is not saved") {
                        XCTAssertNil(frame.roll2)
                    }
                }
            }
        }
    }
}
