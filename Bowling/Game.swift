//
//  Game.swift
//  Bowling
//
//  Created by Mikhail Rubanov on 02/09/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import Foundation

class Game {
    
    private var rolls: [Int] = []
    
    func roll2(_ pins: Int) {
        score += pins
        
        rolls.append(pins)
        if rolls.count > 2 {
            let i = rolls.count - 1
            let isFirstRollInFrame = i % 2 == 0
            if isFirstRollInFrame {
                let isSpare = rolls[i-1] + rolls[i-2] == 10
                if isSpare {
                    score += pins
                }
            }
        }
    }
    
    private var frames: [Frame] = []
    
    func roll(_ pins: Int) {
        if var lastFrame = frames.last, !lastFrame.isFinished {
            lastFrame.roll2 = pins
            frames[frames.count - 1] = lastFrame
        } else {
            let frame = Frame(roll1: pins)
            frames.append(frame)
        }
        
        score += pins
        if frames.count > 1 {
            let isFirstRollInFrame = frames.last!.roll2 == nil
            if isFirstRollInFrame {
                let previousFrame = frames[frames.count - 2]
                if previousFrame.isSpare {
                    score += pins
                }
            }
        }
    }
    
    var score: Int = 0
}
