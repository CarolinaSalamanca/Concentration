//
//  Card.swift
//  Concentration
//
//  Created by Carolina Salamanca on 7/8/20.
//  Copyright © 2020 Carolina Salamanca. All rights reserved.
//

import Foundation

struct Card: Hashable{
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier = 0
    
    private static var identifierFactory = 0
    
    private static func getUniqueId() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueId()
    }
}
