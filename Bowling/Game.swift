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
            
            let nextFrame = self.frame(after: index)
            
            switch frame.type {
            case .spare:
                score += nextFrame?.roll1 ?? additionallRoll ?? 0
            case .strike:
                score += nextFrame?.score ?? additionallRoll ?? 0
            case .regular:
                break // Do nothing
            }
        }
        
        return score
    }
    
    func roll(_ pins: Int) {
        if isFinished {
            if frames.last?.isStrike ?? false
                || frames.last?.isSpare ?? false {
                additionallRoll = pins
            }
        } else {
            appendOrCreateFrame(pins)
        }
    }
    
    var isFinished: Bool {
        return frames.count == 10 && (frames.last?.isFinished ?? false)
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
    
    private var frames: [Frame] = []
}
