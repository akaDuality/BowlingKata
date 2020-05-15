//
//  RollBoard.swift
//  Bowling
//
//  Created by Mikhail Rubanov on 11.05.2020.
//  Copyright © 2020 akaDuality. All rights reserved.
//

class RollBoard {
    private var rolls: [Int?] = Array(repeating: nil, count: 22)
    private var currentRollIndex = 0

    func addRoll(_ pins: Int) {
        rolls[currentRollIndex] = pins
        
        if pins == 10 {
            if currentRollIndex < 20 {
                currentRollIndex += 2 // Strike closes regular frame
            } else {
                currentRollIndex += 1 // Additional strike
            }
        } else {
            currentRollIndex += 1
        }
    }
    
    var frames: [Frame] {
        var frames = [Frame]()
        for frameIndex in 0...9 {
            guard let roll1 = rolls[frameIndex * 2] else { return frames }
            var frame = Frame(roll1: roll1)
            
            let roll2 = rolls[frameIndex * 2 + 1]
            frame.addRoll(roll2)
            
            frames.append(frame)
        }
        
        return frames
    }
    
    var isFinished: Bool {
        guard let endFrame = frames[safe: 9] else { return false }
        
        if endFrame.isStrike {
            return rolls[20] != nil && rolls[21] != nil
        }
        
        if endFrame.isSpare {
            return rolls[20] != nil
        }
        
        return endFrame.isFinished
    }
    
    func frame(after index: Int) -> Frame? {
        let nextIndex = index + 1
        guard nextIndex < frames.count else { return nil }
        return frames[nextIndex]
    }
    
    func roll(afterFrame frameIndex: Int) -> Int {
        return rolls[(frameIndex + 1) * 2] ?? 0
    }
    
    func sumOfTwoRolls(afterFrame frameIndex: Int) -> Int {
        if frameIndex < 9 {
            let nextFrameIndex = frameIndex + 1
            
            var summ = rolls[nextFrameIndex * 2] ?? 0
            
            if let roll2 = rolls[nextFrameIndex * 2 + 1] {
                summ += roll2
            }
            else if let roll3 = rolls[nextFrameIndex * 2 + 2] {
                summ += roll3
            }
            
            return summ
        } else {
            return 0
        }
    }
    
    func additioanlRolls() -> Int {
        (rolls[20] ?? 0) + (rolls[21] ?? 0)
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        if index < count {
            return self[index]
        } else {
            return nil
        }
    }
}
