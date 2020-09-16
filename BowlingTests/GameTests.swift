//
//  GameTests.swift
//  BowlingTests
//
//  Created by Mikhail Rubanov on 02/09/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

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
                    beforeEach {
                        game.roll(4)
                    }
                    
                    it("should add roll to score") {
                        expect(game.score) == 9
                    }
                }
            }
            
            // MARK: - Spare
            context("when roll spare") {
                beforeEach {
                    game.spare(first: 4)
                }
                
                it("should double next roll") {
                    game.roll(6)
                    expect(game.score) == (4 + 6) + (6*2)
                }
                
                context("when next 2 roll also spare") {
                    beforeEach {
                        game.spare(first: 6)
                    }
                    
                    it("should double 3rd roll, not frame score") {
                        expect(game.score) == (4 + 6) + (6*2 + 4)
                    }
                    
                    context("when roll 2") {
                        beforeEach {
                            game.roll(2)
                        }
                        
                        it("should double") {
                            let score: Int = (4 + 6) + (6*2 + 4) + (2*2)
                            expect(game.score) == score
                        }
                    }
                }
                
                context("when roll same spare") {
                    beforeEach {
                        game.spare(first: 2)
                    }
                    
                    it("should not find spare between 8 and 2") {
                        let score: Int = (2 + 8) + (2*2 + 8)
                        expect(game.score) == score
                    }
                }
            }
            
            // MARK: - Strike
            context("when roll strike") {
                beforeEach {
                    game.strike()
                }
                
                it("should double two next roll") {
                    game.roll(4)
                    game.roll(2)
                    
                    expect(game.score) == 10 + 2*4 + 2*2
                }
                
                context("when two next roll also stike") {
                    beforeEach {
                        game.strike()
                        game.strike()
                    }
                    
                    it("should double both, and 2nd double 3rd") {
                        expect(game.score) == 10 + 2*10 + 3*10
                    }
                }
            }

            // MARK: - Endgame
            describe("ending") {
                it("on start game not finished") {
                    expect(game.isFinished) == false
                }

                context("when game is played 19 times") {
                    beforeEach {
                        game.roll(1, times: 19)
                    }

                    it("should not finish game") {
                        expect(game.isFinished) == false
                    }
                }

                context("when game is played 20 times") {
                    beforeEach {
                        game.roll(1, times: 20)
                    }

                    it("should finish game") {
                        expect(game.isFinished) == true
                    }

                    context("when roll after game end") {
                        beforeEach {
                            game.roll(1)
                        }

                        it("should not add pins to score") {
                            expect(game.score) == 20
                        }
                    }
                }

                describe("last frame") {
                    beforeEach {
                        game.roll(1, times: 18)
                    }

                    context("when spare") {
                        beforeEach {
                            game.spare()
                        }

                        it("should allow additioanal roll") {
                            expect(game.isFinished) == false
                        }

                        context("when perform additional roll") {
                            beforeEach {
                                game.roll(3)
                            }
                            it("should finish game") {
                                expect(game.isFinished) == true
                            }

                            it("should double last roll") {
                                expect(game.score) == 18 + 10 + 3*2
                            }
                        }
                    }

                    context("when stike") {
                        beforeEach {
                            game.strike()
                        }

                        it("should allow two additional roll") {
                            expect(game.isFinished) == false
                        }

                        context("when perform 1st additional roll") {
                            beforeEach {
                                game.roll(3)
                            }
                            it("should finish game") {
                                expect(game.isFinished) == false
                            }

                            context("when perform 2nd additional roll") {
                                beforeEach {
                                    game.roll(3)
                                }
                                it("should finish game") {
                                    expect(game.isFinished) == true
                                }
                            }
                        }
                    }
                }
            }

            context("when roll 10 stike in row") {
                beforeEach {
                    game.roll(10, times: 10)
                }

                describe("should allow two additional roll") {
                    context("when perform 1st stike") {
                        beforeEach {
                            game.strike()
                        }
                        it("should not finish game") {
                            expect(game.isFinished) == false
                        }
                        
                        it("should score 290") {
                            expect(game.score) == 290
                        }

                        context("when perform 2nd stike") {
                            beforeEach {
                                game.strike()
                            }
                            it("should finish game") {
                                expect(game.isFinished) == true
                            }

                            it("should hit maximum score") {
                                expect(game.score) == 300
                            }
                        }
                    }
                }
            }
        }
        
        #warning("add output: split, false and foul. ")
    }
}

extension Game {
    func spare(first: Int = 4) {
        roll(first)
        roll(10-first)
    }
    
    func strike() {
        roll(10)
    }
    
    func roll(_ pins: Int, times: Int) {
        for _ in 0..<times {
            roll(pins)
        }
    }
}
