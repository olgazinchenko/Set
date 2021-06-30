//
//  ViewController.swift
//  Set
//
//  Created by Ольга on 18.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        cards = []
        cards = cardsGenerator()
        renderCards()
        inGameCards = pickInGameCards(amount: 15)
        updateViewFromModel()
    }
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            selectAndDeselecCards(by: cardNumber)
        } else {
            print("Choosen card not in cardButtons")
        }
    }
    @IBOutlet weak var addCardsStackView: UIStackView!
    @IBAction func addCardsButton(_ sender: UIButton) {
        addCards()
    }
    
    var cards = [Card]()
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
    var numberOfShapes = 3
    var index = 0
    func cardsGenerator() -> [Card] {
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
    func pickInGameCards(amount: Int) -> [Card] {
        for _ in 0...amount - 1 {
            let randomCardIndex = cards.indices.randomElement()!
            inGameCards.append(cards[randomCardIndex])
            cards.remove(at: randomCardIndex)
        }
    return inGameCards
    }
    
    func renderCards() {
        addCardsStackView.isHidden = true
        for index in cardButtons.indices {
            cardButtons[index].layer.borderWidth = 3.0
            cardButtons[index].layer.borderColor = UIColor.gray.cgColor
            cardButtons[index].layer.cornerRadius = 8.0
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = inGameCards[index]
            if card.numberOfShapes == 1 {
                button.setTitle(String(card.shape), for: UIControl.State.normal)
            } else if card.numberOfShapes == 2 {
                button.setTitle(String(card.shape) + String(card.shape), for: UIControl.State.normal)
            } else {
                button.setTitle(String(card.shape) + String(card.shape) + String(card.shape), for: UIControl.State.normal)
            }
            button.setTitleColor(card.color, for: UIControl.State.normal)
        }
    }
    
    func selectAndDeselecCards(by index: Int){
        var selectedCardsNumber = 0
        for index in inGameCards.indices {
            if inGameCards[index].isSelected == true {
                selectedCardsNumber += 1
            }
        }
        if cardButtons[index].layer.borderColor == UIColor.gray.cgColor, selectedCardsNumber < 3  {
            cardButtons[index].layer.borderColor = UIColor.green.cgColor
            inGameCards[index].isSelected = true
        }
        else {
            cardButtons[index].layer.borderColor = UIColor.gray.cgColor
            inGameCards[index].isSelected = false
            selectedCardsNumber -= 1
        }
    }
    
    func addCards() {
        UIView.animate(withDuration: 0.5, animations:  {
            self.addCardsStackView.isHidden = false
        })
    }
    
//TODO: Requirements
    //After 3 cards have been selected, you must indicate whether those 3 cards are a match or a mismatch (per Set rules). You can do this with coloration or however you choose, but it should be clear to the user whether the 3 cards they selected match or not.
    
    //You will also need a “Deal 3 More Cards” button (as per the rules of Set).
    //When the Deal 3 More Cards button is pressed either a) replace the selected cards if they are a match or b) add 3 cards to the game.
    //The Deal 3 More Cards button should be disabled if there are a) no more cards in the Set deck or b) no more room in the UI to fit 3 more cards (note that there is always room for 3 more cards if the 3 currently-selected cards are a match since you replace them).
    
    //Deal 12 cards only to start. They can appear anywhere on screen (i.e. they don’t have to be aligned at the top or bottom or anything; they can be scattered to start if you want), but should not overlap.
    
    //Like you did for Concentration, you must have a New Game button and show the Score in the UI. It is up to you how you want to score your Set game. For example, you could give 3 points for a match and -5 for a mismatch and maybe even -1 for a deselection. Perhaps fewer points are scored depending on how many cards are on the table (i.e. how many times Deal 3 More Cards has been touched). Whatever you think best evaluates how well the player is playing.

    //array with cards on the field and array selected 3 cards
    
    required init?(coder aDecoder: NSCoder) {
        self.cards = [Card]()
        super.init(coder: aDecoder)
    }
}
