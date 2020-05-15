//
//  Frame.swift
//  Bowling
//
//  Created by Mikhail Rubanov on 02/09/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import Foundation

struct Frame {
    var roll1: Int
    private(set) var roll2: Int? = nil
    
    init(roll1: Int) {
        self.roll1 = min(10, roll1)
    }
    
    mutating func addRoll(_ roll2: Int?) {
        if isStrike {
            self.roll2 = nil
        } else {
            if let roll2 = roll2 {
                self.roll2 = min(roll2, max2ndValue)
            } else {
                self.roll2 = nil
            }
        }
    }
    
    private var max2ndValue: Int { maxScore - roll1 }
    
    var isFinished: Bool {
        return roll2 != nil || isStrike
    }
    
    var isSpare: Bool {
        guard let roll2 = roll2 else { return false }
        
        return roll1 + roll2 == maxScore
    }
    
    var isStrike: Bool {
        return roll1 == maxScore
    }
    
    var type: ScoreType {
        if isStrike {
            return .strike
        }
        
        if isSpare {
            return .spare
        }
        
        return .open
    }
    
    var score: Int {
        return roll1 + (roll2 ?? 0)
    }
    
    private let maxScore = 10
    
    enum ScoreType {
        case open
        case spare
        case strike
    }
}
