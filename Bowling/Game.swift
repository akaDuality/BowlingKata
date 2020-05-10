//
//  Game.swift
//  Bowling
//
//  Created by Mikhail Rubanov on 02/09/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import Foundation

class Game {
    
    var score: Int {
        let scoreboard = ScoreBoard(rollboard: rollboard)
        return scoreboard.score
    }
    
    func roll(_ pins: Int) {
        if rollboard.framesAreFinished {
            rollboard.addAdditionalFrameIfPossible(pins)
        } else {
            rollboard.appendOrCreateFrame(pins)
        }
    }

    var isFinished: Bool {
        return rollboard.isFinished
    }
    
    let rollboard = RollBoard()
}

class RollBoard {
    private(set) var frames: [Frame] = []
    private(set) var additionallRoll: Int?
    private(set) var additionallRoll2: Int?
    
    func appendOrCreateFrame(_ pins: Int) {
        if var lastFrame = frames.last, !lastFrame.isFinished {
            lastFrame.roll2 = pins
            frames[frames.count - 1] = lastFrame
        } else {
            let frame = Frame(roll1: pins)
            frames.append(frame)
        }
    }
    
    func addAdditionalFrameIfPossible(_ pins: Int) {
        let lastFrame = frames.last!
        if lastFrame.isStrike || lastFrame.isSpare {
            if additionallRoll == nil {
                additionallRoll = pins
            } else {
                if additionallRoll2 == nil {
                    additionallRoll2 = pins
                }
            }
        }
    }
    
    var isFinished: Bool {
        if framesAreFinished {
            let lastFrame = frames.last!
            
            if lastFrame.isStrike {
                return additionallRoll != nil && additionallRoll2 != nil
            }
            
            if lastFrame.isSpare {
                return additionallRoll != nil
            }
            
            return true
        }
        return false
    }
    
    var framesAreFinished: Bool {
        return frames.count == 10 && frames.last!.isFinished
    }
    
    func frame(after index: Int) -> Frame? {
        let nextIndex = index + 1
        guard nextIndex < frames.count else { return nil }
        return frames[nextIndex]
    }
}

class ScoreBoard {
    init(rollboard: RollBoard) {
        self.rollboard = rollboard
    }
    private let rollboard: RollBoard
    
    var score: Int {
        var score = 0
        for (index, frame) in rollboard.frames.enumerated() {
            score += frame.score
            score += bonusForNextFrame(after: index)
        }

        return score
    }
    
    private func bonusForNextFrame(after index: Int) -> Int {
        let nextFrame = rollboard.frame(after: index)
        
        let additionallRoll = rollboard.additionallRoll
        
        switch rollboard.frames[index].type {
        case .spare:
            return nextFrame?.roll1 ?? ((additionallRoll ?? 0) * 2)
        case .strike:
            if let nextFrame = nextFrame, nextFrame.isStrike {
                if let next2Frame = rollboard.frame(after: index + 1) {
                    return 10 + next2Frame.roll1
                } else {
                    return 10 + (additionallRoll ?? 0)
                }
            } else if (additionallRoll ?? 0) == 10 {
                return 10 + additionallRoll!
            } else {
                return nextFrame?.score ?? additionallRoll ?? 0
            }
        case .open:
            return 0
        }
    }
}
