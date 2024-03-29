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
        var score = 0
        for (index, frame) in frames.enumerated() {
            score += frame.score
            score += additionalScoreForNextFrame(after: index)
        }
        
        return score
    }
    
    func roll(_ pins: Int) {
        if framesAreFinished {
            let lastFrame = frames.last!
            if lastFrame.isStrike || lastFrame.isSpare {
                additionallRoll = pins
            }
        } else {
            appendOrCreateFrame(pins)
        }
    }
    
    private var framesAreFinished: Bool {
        return frames.count == 10 && frames.last!.isFinished
    }
    
    var isFinished: Bool {
        if framesAreFinished {
            if frames.last?.isStrike ?? false {
                return additionallRoll != nil
            } else {
                return true
            }
        }
        return false
    }
    
    private var additionallRoll: Int?
    
    private func frame(after index: Int) -> Frame? {
        let nextIndex = index + 1
        guard nextIndex < frames.count else { return nil }
        return frames[nextIndex]
    }
    
    private func appendOrCreateFrame(_ pins: Int) {
        if var lastFrame = frames.last, !lastFrame.isFinished {
            lastFrame.roll2 = pins
            frames[frames.count - 1] = lastFrame
        } else {
            let frame = Frame(roll1: pins)
            frames.append(frame)
        }
    }
    
    private func additionalScoreForNextFrame(after index: Int) -> Int {
        let nextFrame = frame(after: index)
        
        switch frames[index].type {
        case .spare:
            return nextFrame?.roll1 ?? additionallRoll ?? 0
        case .strike:
            if let nextFrame = nextFrame, nextFrame.isStrike {
                if let next2Frame = frame(after: index + 1) {
                    return 10 + next2Frame.roll1
                } else {
                    return 10 + (additionallRoll ?? 0)
                }
            } else if (additionallRoll ?? 0) == 10 {
                return 10 + (additionallRoll ?? 0)
            } else {
                return nextFrame?.score ?? additionallRoll ?? 0
            }
        case .regular:
            return 0
        }
    }
    
    private var frames: [Frame] = []
}
