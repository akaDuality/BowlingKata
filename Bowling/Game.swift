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
            score += additionalScoresForNextFrame(after: index)
        }
        
        return score
    }
    
    func roll(_ pins: Int) {
        if isFinished {
            let lastFrame = frames.last!
            if lastFrame.isStrike || lastFrame.isSpare {
                additionallRoll = pins
            }
        } else {
            appendOrCreateFrame(pins)
        }
    }
    
    var isFinished: Bool {
        return frames.count == 10 && frames.last!.isFinished
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
    
    private func additionalScoresForNextFrame(after index: Int) -> Int {
        let nextFrame = self.frame(after: index)
        
        switch frames[index].type {
        case .spare:
            return nextFrame?.roll1 ?? additionallRoll ?? 0
        case .strike:
            return nextFrame?.score ?? additionallRoll ?? 0
        case .regular:
            return 0
        }
    }
    
    private var frames: [Frame] = []
}
