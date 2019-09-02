//
//  Game.swift
//  Bowling
//
//  Created by Mikhail Rubanov on 02/09/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import Foundation

class Game {
    
    var score: Int = 0
    
    func roll(_ pins: Int) {
        let lastFrame = add(pins)
        
        score += pins
        if previousFrame?.isSpare ?? false {
            if !lastFrame.isFinished {
                score += pins
            }
        }
    }
    
    private var previousFrame: Frame? {
        guard frames.count > 1 else { return nil }
        
        let lastIndex = frames.count - 1
        let previousFrame = frames[lastIndex - 1]
        return previousFrame
    }
    
    private func add(_ pins: Int) -> Frame {
        if var lastFrame = frames.last, !lastFrame.isFinished {
            lastFrame.roll2 = pins
            frames[frames.count - 1] = lastFrame
            return lastFrame
        } else {
            let frame = Frame(roll1: pins)
            frames.append(frame)
            
            return frame
        }
    }
    
    private var frames: [Frame] = []
}
