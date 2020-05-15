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
        guard !rollboard.isFinished else { return }

        rollboard.addRoll(pins)
    }

    var isFinished: Bool {
        return rollboard.isFinished
    }
    
    let rollboard = RollBoard()
}

class ScoreBoard {
    init(rollboard: RollBoard) {
        self.rollboard = rollboard
    }
    private let rollboard: RollBoard
    
    var score: Int {
        let framesScore = rollboard.frames.reduce(0, { $0 + $1.score })

        let frameBonuses = (0..<rollboard.frames.count).map { index in
            bonusForNextFrame(after: index)
        }
        
        let framesBonusesScore = frameBonuses.reduce(0, +)

        return framesScore + framesBonusesScore + rollboard.additioanlRolls()
    }
    
    private func bonusForNextFrame(after index: Int) -> Int {
        switch rollboard.frames[index].type {
        case .spare:    return rollboard.roll(afterFrame: index)
        case .strike:   return rollboard.sumOfTwoRolls(afterFrame: index)
        case .open:     return 0
        }
    }
}
