//
//  Set.swift
//  Set
//
//  Created by Ольга on 22.06.2021.
//

import Foundation

struct Set {
    
    var cards = [Card]()
    
    func selectCards() {
        //maybe this method should be in the ViewController (!)
    }
    
    func checkCardsMaching() {
        //checking 3 cards maching
        //if non-maching Set - deselect those 3 non-matching cards and then select the chosen card
        //if 3 matching Set cards selected, replace those 3 matching Set cards with new ones from the deck of 81 Set cards.
        //if the deck is empty then matched cards can’t be replaced, but they should be hidden in the UI.
        //if the card that was chosen was one of the 3 matching cards, then no card should be selected (since the selected card was either replaced or is no longer visible in the UI).
    }
}
