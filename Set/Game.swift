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
    var matchedCards = [Card]()
    var index = 0
    var score = 0
    
    mutating func cardsGenerator() -> [Card] {
        //The method generates an array of 81 cards
        let variants = Card.Variant.allVariants
        for shape in variants {
            for color in variants {
                    for number in variants {
                        for shade in variants {
                            cards += [Card(identifier: index, color: color, shade: shade, shape: shape, numberOfShapes: number)]
                            index += 1
                        }
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
        var allShadesAreSame = false
        var allShadesAreDifferent = false
        var allColorsAreSame = false
        var allColorsAreDifferent = false
        if selectedCardsCount == 3 {
            if selectedCards[0].shape == selectedCards[1].shape, selectedCards[1].shape == selectedCards[2].shape {
                allShapesAreSame = true
            }
            if selectedCards[0].shape != selectedCards[1].shape, selectedCards[1].shape != selectedCards[2].shape, selectedCards[0].shape != selectedCards[2].shape {
                allShapesAreDifferent = true
            }
            if selectedCards[0].numberOfShapes == selectedCards[1].numberOfShapes, selectedCards[1].numberOfShapes == selectedCards[2].numberOfShapes {
                equalNumberOfShapes = true
            } else if selectedCards[0].numberOfShapes != selectedCards[1].numberOfShapes, selectedCards[1].numberOfShapes != selectedCards[2].numberOfShapes, selectedCards[0].numberOfShapes != selectedCards[2].numberOfShapes {
                unequalNumberOfShapes = true
            }
            if selectedCards[0].shade == selectedCards[1].shade, selectedCards[1].shade == selectedCards[2].shade {
                allShadesAreSame = true
            }
            if selectedCards[0].shade != selectedCards[1].shade, selectedCards[1].shade != selectedCards[2].shade, selectedCards[0].shade != selectedCards[2].shade {
                allShadesAreDifferent = true
            }
            if selectedCards[0].color == selectedCards[1].color, selectedCards[1].color == selectedCards[2].color {
                allColorsAreSame = true
            }
            if selectedCards[0].color != selectedCards[1].color, selectedCards[1].color != selectedCards[2].color, selectedCards[0].color != selectedCards[2].color {
                allColorsAreDifferent = true
            }
            if allShapesAreDifferent || allShapesAreSame, equalNumberOfShapes || unequalNumberOfShapes, allShadesAreSame || allShadesAreDifferent, allColorsAreSame || allColorsAreDifferent {
                isSet = true
                addTreePointsToScoreWhenTheSetIsMatch()
            } else {
                addFivePointPenaltiesToScoreWhenTheSetIsMismatch()
            }
        }
    return isSet
    }
    
    mutating func addTreePointsToScoreWhenTheSetIsMatch() {
        self.score += 3
    }
    
    mutating func addFivePointPenaltiesToScoreWhenTheSetIsMismatch() {
        self.score -= 5
    }
    
    mutating func addOnePointPenaltyToScoreWhenAddedMoreCards() {
        self.score -= 1
    }

    mutating func resetTheScore() {
        self.score = 0
    }
    
    init() {
        cards = cardsGenerator()
    }
}
