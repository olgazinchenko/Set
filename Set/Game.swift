//
//  Game.swift
//  Set
//
//  Created by Ольга on 22.06.2021.
//

import Foundation
import UIKit

struct Game {
    
    var cards = [Card]()
    var numberOfShapes = 3
    var shapes: [Character] = ["▲","●","■"]
    var colors: [UIColor] = [
        UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.15),
        UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.15),
        UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.15),
        UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5),
        UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5),
        UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.5),
        UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
        UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0),
        UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
    ]
    var index = 0
    mutating func cardsGenerator() -> [Card] {
        //The method generates an array of 81 cards
            for shape in shapes {
                for color in colors {
                    for number in 1...numberOfShapes {
                        cards += [Card(identifier: index, color: color, shape: shape, numberOfShapes: number)]
                        index += 1
                    }
                }
            }
        return cards
    }
    
    var inGameCards = [Card]()
    mutating func pickInGameCards(amount: Int) -> [Card]{
        for _ in 0...amount - 1 {
            let randomCardIndex = cards.indices.randomElement()!
            inGameCards.append(cards[randomCardIndex])
            cards.remove(at: randomCardIndex)
        }
    return inGameCards
    }
    
    mutating func isSet(selectedCards: [Card]) -> Bool {
        var isSet = false
        let selectedCardsCount = selectedCards.count
        var allShapesAreSame = false
        var allShapesAreDifferent = false
        var equalNumberOfShapes = false
        var unequalNumberOfShapes = false
        if selectedCardsCount == 3, selectedCards[0].shape == selectedCards[1].shape, selectedCards[1].shape == selectedCards[2].shape {
            allShapesAreSame = true
        } else if selectedCardsCount == 3, selectedCards[0].shape != selectedCards[1].shape, selectedCards[1].shape != selectedCards[2].shape, selectedCards[0].shape != selectedCards[2].shape {
            allShapesAreDifferent = true
        }
        if selectedCardsCount == 3, selectedCards[0].numberOfShapes == selectedCards[1].numberOfShapes, selectedCards[1].numberOfShapes == selectedCards[2].numberOfShapes {
            equalNumberOfShapes = true
        } else if selectedCardsCount == 3, selectedCards[0].numberOfShapes != selectedCards[1].numberOfShapes, selectedCards[1].numberOfShapes != selectedCards[2].numberOfShapes, selectedCards[0].numberOfShapes != selectedCards[2].numberOfShapes {
            unequalNumberOfShapes = true
        }
        if allShapesAreDifferent || allShapesAreSame, equalNumberOfShapes || unequalNumberOfShapes {
            isSet = true
        }
    return isSet
    }
    
    init() {
        cards = cardsGenerator()
    }
}