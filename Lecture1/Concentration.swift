//
//  Concentration.swift
//  Lecture1
//
//  Created by Elif Yurt on 16.02.2019.
//  Copyright © 2019 Elif Yurt. All rights reserved.
//

import Foundation

//MODEL

struct Concentration{
    
    private(set) var cards = [Card]()
    var score = 0
    
    private var indexIfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index:Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexIfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex] == cards[index]{
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
            } else{
                indexIfOneAndOnlyFaceUpCard = index
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            //cards.append(card)
            //cards.append(card)
            cards += [card,card]
            cards.shuffle()
        }
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
