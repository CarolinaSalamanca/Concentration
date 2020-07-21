//
//  Concentration.swift
//  Concentration
//
//  Created by Carolina Salamanca on 7/8/20.
//  Copyright © 2020 Carolina Salamanca. All rights reserved.
//

import Foundation

class Concentration{
    private (set) var cards = [Card]() // this property is setteable only from within this file (private) vant be setteable from another file but
    // is getteable from any file because its get property is still internal (default)
    
    private var facedUpCard : Int?{
        get{
            let facedUpcardIndices = cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly // this will return an array with the up-sided cards
            //return facedUpcardIndices.count == 1 ? facedUpcardIndices.first : nil // if theres one card up, return the first card found
            //this function is implemented as an exension below and called on the up line
            return facedUpcardIndices
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        //debug-only checks that will force your app to crash if the condition IS NOT true.
        assert(cards.indices.contains(index), "index notin the cards")
        if !cards[index].isMatched{ // if the card isn't matched
            if let matchIndex = facedUpCard, matchIndex != index{ // compares if theres a card up and saves that index,compares  that the same button isnt pressed
                if cards[matchIndex] == cards[index]{ // if the previous old up card is the same as the current up card
                    cards[matchIndex].isMatched = true // marks the two cards as matched
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true // turns the recent card up
            }
            else{
                facedUpCard = index // saves that index
            }
        }
    }
    
    init(pairNumbers: Int){
        assert(pairNumbers > 0, "at least one pair needed" )
        for _ in 1...pairNumbers {
            let card = Card()
            cards += [card,card]
        }
    }
    
}

extension Collection{
    var oneAndOnly: Element?{
        return count == 1 ? first : nil
    }
}
