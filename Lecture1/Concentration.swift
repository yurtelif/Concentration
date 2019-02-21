//
//  Concentration.swift
//  Lecture1
//
//  Created by Elif Yurt on 16.02.2019.
//  Copyright © 2019 Elif Yurt. All rights reserved.
//

import Foundation

//MODEL

class Concentration{
    
    var cards = [Card]()
    var score = 0
    
    var indexIfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index:Int){
        if !cards[index].isMatched{
            if let matchIndex = indexIfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                else{
                    if cards[index].isSeen || cards[matchIndex].isSeen{
                        score -= 1
                    }
                    cards[index].isSeen = true
                    cards[matchIndex].isSeen = true
                }
                cards[index].isFaceUp = true
                indexIfOneAndOnlyFaceUpCard = nil
            } else{
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
            
                cards[index].isFaceUp = true
                indexIfOneAndOnlyFaceUpCard = index
                
                
            }
        }
    }
    
    
    
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            //cards.append(card)
            //cards.append(card)
            cards += [card,card]
            cards.shuffle()
        }
 
        //TODO: Shuffle the cards

        
        
    }
    
}
