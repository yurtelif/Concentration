//
//  ViewController.swift
//  Lecture1
//
//  Created by Elif Yurt on 16.02.2019.
//  Copyright © 2019 Elif Yurt. All rights reserved.
//

import UIKit

//CONTROLLER

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count+1) / 2
    }
    
    
    private var emojiChoicees = ["😱","💜","🏀","🐗","🐍","🙋🏻‍♀","🥶","☠️"]

    
    private var emojiTheme = ["😎","😱","😤","🤥","😂","😒","😶","🤔"];
    private var animalTheme = [ "🐷","🦁","🦅","🦋","🐘","🦀","🐢","🐠"];
    private var fruitTheme = [ "🍉","🍓","🍅","🥝","🍋","🍇","🍍","🍏"];
    private var ballTheme = [ "⚽","🏀","🏈","⚾","🎾","🏐","🏉","🎱"];
    private var vehicleTheme = [ "🚗","🚌","⛵","🛳","✈","🚀","🚡","🚅"];
    private var heartTheme = [ "❤","🧡","💛","💚","💙","💜","🖤","💔"];
    private var themeArray: [[String]] = []
    
    private(set) var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func startNewGame(_ sender: Any) {
        createNewGame()
    }
    

    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else{
            print("card is not in the set")
        }
        scoreLabel.text = "Score: \(game.score)"
    }

    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0):#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emoji = [Int:String]()

    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoicees.count > 0 {
            emoji[card.identifier] = emojiChoicees.remove(at: emojiChoicees.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func createNewGame(){
        themeArray = [emojiTheme, animalTheme, fruitTheme, vehicleTheme, heartTheme, ballTheme]
        emojiChoicees = themeArray[themeArray.count.arc4random]
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
        flipCount = 0
        clearButtons()
    }
    
    private func clearButtons(){
        for card in cardButtons{
            card.setTitle("", for: UIControl.State.normal)
            card.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
          return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}

