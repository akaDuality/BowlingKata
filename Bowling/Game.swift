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
    
    func roll(_ pins: Int) {
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
    
    var score: Int = 0
}
