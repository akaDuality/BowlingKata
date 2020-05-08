//
//  GameTests.swift
//  BowlingTests
//
//  Created by Mikhail Rubanov on 02/09/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import XCTest
@testable import Bowling

import Quick
import Nimble

class GameSpec: QuickSpec {
    override func spec() {
        describe("game") {
            var game: Game!
            beforeEach {
                game = Game()
            }
            
            it("score starts from zero") {
                expect(game.score) == 0
            }
            
            context("when roll 5") {
                beforeEach {
                    game.roll(5)
                }
                
                it("should set score to 5") {
                    expect(game.score) == 5
                }
                
                context("and roll 4") {
                    it("should add roll to score") {
                        game.roll(4)
                        expect(game.score) == 9
                    }
                }
            }
            
            context("when roll 2") {
                beforeEach {
                    game.roll(2)
                }
                context("and roll 8") {
                    beforeEach {
                        game.roll(8)
                    }
                    it("is spare and double next roll") {
                        game.roll(4)
                        expect(game.score) == 2 + 8 + 4 * 2
                    }
                    
                    context("when next 2 roll also spare") {
                        beforeEach {
                            game.spare(first: 4)
                        }
                        
                        it("should double 3rd and 5 rolls") {
                            let score: Int = (2 + 8) + (4*2 + 6)
                            expect(game.score).to(equal(score))
                        }
                        
                        context("when roll 2") {
                            beforeEach {
                                game.roll(2)
                            }
                            
                            it("should double") {
                                let score: Int = (2 + 8) + (4*2 + 6) + 2*2
                                expect(game.score).to(equal(score))
                            }
                        }
                    }
                    
                    context("when roll same spare") {
                        beforeEach {
                            game.spare(first: 2)
                        }
                        
                        it("should not find spare between 8 and 2") {
                            let score: Int = (2 + 8) + (2*2 + 8)
                            expect(game.score).to(equal(score))
                        }
                    }
                }
            }
        }
    }
}

class GameTests: XCTestCase {
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

extension Game {
    func spare(first: Int = 4) {
        roll(first)
        roll(10-first)
    }
}
