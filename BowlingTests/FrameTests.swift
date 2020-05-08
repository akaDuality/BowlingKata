//
//  FrameTests.swift
//  BowlingTests
//
//  Created by Mikhail Rubanov on 02/09/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

@testable import Bowling

import Quick
import Nimble

class FrameSpec: QuickSpec {
    override func spec() {
        describe("frame") {
            var frame: Frame!
            beforeEach {
                frame = Frame(roll1: 4)
            }

            context("starts from one roll") {
                it("save 1st roll") {
                    expect(frame.roll1) == 4
                }
                
                it("2nd roll is nil") {
                    expect(frame.roll2).to(beNil())
                }
                
                it("is not finished") {
                    expect(frame.isFinished) == false
                }
            }
            
            context("when roll 2nd time") {
                beforeEach {
                    frame.roll2 = 3
                }
                
                it("has 2nd roll") {
                    expect(frame.roll2) == 3
                }
                
                it("score is summ of two rolls") {
                    expect(frame.score) == 7
                }
                
                it("frame is finished") {
                    expect(frame.isFinished) == true
                }
                
                it("is not spare") {
                    expect(frame.isSpare) == false
                }
            }
            
            context("when sum of two rolls more than 10") {
                beforeEach {
                    frame.roll2 = 10
                }
                
                it("should limit by 10") {
                    expect(frame.score) == 10
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
                    expect(frame.isStrike) == false
                }
            }
            
            
            context("when 2nd roll hit all elapsed pins") {
                beforeEach {
                    frame.roll2 = 6
                }
                
                it("is spare") {
                    expect(frame.isSpare) == true
                }
            }
        }
        
        describe("strike") {
            context("when all pins is hit by 1st roll") {
                let frame = Frame(roll1: 10)
                
                it("is strike") {
                    expect(frame.isStrike) == true
                }
                
                it("finishes frame") {
                    expect(frame.isFinished) == true
                }
                
                it("not a spare") {
                    expect(frame.isSpare) == false
                }
                
                context("when roll 2nd time") {
                    it("score is stay 10") {
                        expect(frame.score) == 10
                    }
                    
                    it("2nd roll is not saved") {
                        expect(frame.roll2).to(beNil())
                    }
                }
            }
        }
    }
}
