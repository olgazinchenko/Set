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
    mutating func pickInGameCards(amount: Int) -> [Card] {
        for _ in 0...amount - 1 {
            let randomCardIndex = cards.indices.randomElement()!
            inGameCards.append(cards[randomCardIndex])
            cards.remove(at: randomCardIndex)
        }
    return inGameCards
    }
    
    mutating func isSet(in selectedCards:[Card]) -> Bool {
        var isSet = false
        for _ in selectedCards.indices {
            if selectedCards[0].color == selectedCards[1].color && selectedCards[1].color == selectedCards[2].color {
                isSet = true
            }
        }
        return isSet
    }
    
    init() {
        cards = cardsGenerator()
    }
        //checking 3 cards maching
        //if non-maching Set - deselect those 3 non-matching cards and then select the chosen card
        //if 3 matching Set cards selected, replace those 3 matching Set cards with new ones from the deck of 81 Set cards.
        //if the deck is empty then matched cards can’t be replaced, but they should be hidden in the UI.
        //if the card that was chosen was one of the 3 matching cards, then no card should be selected (since the selected card was either replaced or is no longer visible in the UI).
}
