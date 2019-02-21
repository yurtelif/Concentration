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
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    var emojiChoicees = ["😱","💜","🏀","🐗","🐍","🙋🏻‍♀","🥶","☠️"]

    
    var emojiTheme = ["😎","😱","😤","🤥","😂","😒","😶","🤔"];
    var animalTheme = [ "🐷","🦁","🦅","🦋","🐘","🦀","🐢","🐠"];
    var fruitTheme = [ "🍉","🍓","🍅","🥝","🍋","🍇","🍍","🍏"];
    var ballTheme = [ "⚽","🏀","🏈","⚾","🎾","🏐","🏉","🎱"];
    var vehicleTheme = [ "🚗","🚌","⛵","🛳","✈","🚀","🚡","🚅"];
    var heartTheme = [ "❤","🧡","💛","💚","💙","💜","🖤","💔"];
    var themeArray: [[String]] = []
    
    var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func startNewGame(_ sender: Any) {
        createNewGame()
    }
    

    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else{
            print("card is not in the set")
        }
        scoreLabel.text = "Score: \(game.score)"
    }

    func updateViewFromModel(){
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
    
    var emoji = [Int:String]()

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoicees.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoicees.count)))
            emoji[card.identifier] = emojiChoicees.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func createNewGame(){
        themeArray = [emojiTheme, animalTheme, fruitTheme, vehicleTheme, heartTheme, ballTheme]
        let randomIndex = Int(arc4random_uniform(UInt32(themeArray.count)))
        emojiChoicees = themeArray[randomIndex]
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
        flipCount = 0
        clearButtons()
    }
    
    func clearButtons(){
        for card in cardButtons{
            card.setTitle("", for: UIControl.State.normal)
            card.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
    
}

