//
//  ViewController.swift
//  Lecture1
//
//  Created by Elif Yurt on 16.02.2019.
//  Copyright © 2019 Elif Yurt. All rights reserved.
//

import UIKit

//CONTROLLER

class ConcentrationViewController: VCLLoggingViewController {
    
    override var vcLoggingName: String {
        return  "Game"
    }
    
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count+1) / 2
    }
    
    
    private var emojiChoicees = "😱💜🏀🐗🐍🙋🏻‍♀🥶☠️"

    
    private var emojiTheme = "😎😱😤🤥😂😒😶🤔"
    private var animalTheme = "🐷🦁🦅🦋🐘🦀🐢🐠"
    private var fruitTheme = "🍉🍓🍅🥝🍋🍇🍍🍏"
    private var ballTheme = "⚽🏀🏈⚾🎾🏐🏉🎱"
    private var vehicleTheme = "🚗🚌⛵🛳✈🚀🚡🚅"
    private var heartTheme = "❤🧡💛💚💙💜🖤💔"
    private var themeArray: [String] = []
    
    var theme: String? {
        didSet {
            emojiChoicees = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private(set) var flipCount = 0{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
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
        if cardButtons != nil {
            for index in cardButtons.indices{
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp{
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }
                else{
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0):#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
        }
        
    }
    
    private var emoji = [Card:String]()

    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoicees.count > 0 {
            let randomStringIndex = emojiChoicees.index(emojiChoicees.startIndex, offsetBy: emojiChoicees.count.arc4random)
            emoji[card] = String(emojiChoicees.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
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
            card.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
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

