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
    var roll2: Int? = nil
    
    init(roll1: Int) {
        self.roll1 = roll1
    }
    
    var isFinished: Bool {
        return roll2 != nil
    }
}
