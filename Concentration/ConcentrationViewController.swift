//
//  ViewController.swift
//  Concentration
//
//  Created by Carolina Salamanca on 7/8/20.
//  Copyright © 2020 Carolina Salamanca. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    var theme: String?{
        didSet{
            emojiChoices = theme ?? ""
            emojiDictionary = [:] // dictionary
            updateViewFromModel()
        }
    }
    @IBOutlet private var cardButtonsArray: [UIButton]! // contains a reference to all the view's buttons
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateColor()
        }
    } // Label weak reference, optional, when printed it doesnt need ! it will be unwrapped but if its nil it will crash the app
    
    //    private var emojiChoices = ["🚛","🎹","🌚","🌸","🌼","🌈","💥","☂️","🐶","😞"]
    private var emojiChoices = "🚛🎹🌚🌸🌼🌈"
    private var emojiDictionary = [Card: String]()
    
    // its initialized as lazy because in order to use any of its properties (cardButtons),
    // the instance has to be already FULLY INITIALIZED, but we are in the proccess of initializing (game = ...)
    // lazy properties cant have observers
    
    private lazy var game = Concentration(pairNumbers: numberOfPairs)
    
    // Computed property, read only, get not necessary bc its read only, constants let cant be computed props
    var numberOfPairs: Int{
        return cardButtonsArray.count / 2
    }
    
    private (set) var flipCount = 0 {
        didSet {
            updateColor()
        }
    }
    
    private func updateColor(){
        let attrributes: [NSAttributedString.Key: Any] = [
            //            .strokeWidth: 5.0,
            .strokeColor:  #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attrributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardIndex = cardButtonsArray.firstIndex(of: sender){// if individual button view is in the array declared
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        }
        else{
            print("Chosen card wasn't in card buttons")
        }
    }
    
    private func updateViewFromModel(){
        if cardButtonsArray != nil {
            for index in cardButtonsArray.indices{
                let button = cardButtonsArray[index]
                let card = game.cards[index]
                if card.isFaceUp{
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
                else{
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if  emojiDictionary [card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.randomNumber)
            emojiDictionary[card] = String(emojiChoices.remove(at: randomIndex))
        }
        return  emojiDictionary[card] ?? "?"
    }
}

let op1 = {(number: Int) -> Int in return number * 5 }// this is a closure
let op2 = {(number: Int) -> Int in number * 5 } // this is also a closure, it omits return bc its only one line
let op3 = {(number: Int) in number * 5 } // this is also a closure, it knows the return type
let op4 = {(number) in number * 5 } // this is also a closure, it omits the argument type
let op5 = { $0 * 5 } // this is also a closure, it omits the argument's name, arguments can be accessed by $0, $1, $2 and so on

let numberArray = [1,3,4,3,5,3,9]
let idk = numberArray.map({$0 * 5}) // passing a closure as a parameter

// --------- TRAILING CLOSURE (put outside the parentheses) ------------
// they're suppossed to be put outside bc they're too long to be written in the same line or inside the parentheses
let idk2 = numberArray.map(){$0 * 5} // if the closure is the only or last parameter it can be put outside parentheses
let idk3 = numberArray.map{$0 * 5} // if the closure is the only or last parameter it can be put without parentheses

extension Int{
    var randomNumber: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
