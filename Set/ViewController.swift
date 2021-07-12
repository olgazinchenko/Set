//
//  ViewController.swift
//  Set
//
//  Created by Ольга on 18.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var game = Game()

    override func viewDidLoad() {
        renderCards()
        game.inGameCards = game.pickInGameCards(amount: cardButtons.count)
        updateViewFromModel()
        hideAdditionalCards()
    }

    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            selectAndDeselecCards(by: cardNumber)
            let selectedCardsInGame = selectedCards()
            let isSet = game.isSet(selectedCards: selectedCardsInGame)
            inticateIsSetResult(isSetResult: isSet)
            if isSet {
                replaceMatchingSetCards(isSetResult: isSet)
            }
        } else {
            print("Choosen card not in cardButtons")
        }
    }
    @IBOutlet weak var addCardsStackView: UIStackView!
    @IBOutlet var addCardsStackViews: [UIStackView]!
    @IBOutlet weak var addCardsButton: UIButton!
    @IBAction func touchAddCardsButton(_ sender: UIButton) {
        addCards()
        disableAddCardsButton()
    }
    
    func renderCards() {
        for index in cardButtons.indices {
            cardButtons[index].layer.borderWidth = 2.0
            cardButtons[index].layer.borderColor = UIColor.gray.cgColor
            cardButtons[index].layer.cornerRadius = 8.0
        }
    }
    
    func hideAdditionalCards() {
        for index in addCardsStackViews.indices {
            addCardsStackViews[index].isHidden = true
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.inGameCards[index]
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
        for index in game.inGameCards.indices {
            if game.inGameCards[index].isSelected == true {
                selectedCardsNumber += 1
            }
        }
        if cardButtons[index].layer.borderColor == UIColor.gray.cgColor, selectedCardsNumber < 3  {
            cardButtons[index].layer.borderColor = UIColor.green.cgColor
            game.inGameCards[index].isSelected = true
        }
        else {
            cardButtons[index].layer.borderColor = UIColor.gray.cgColor
            game.inGameCards[index].isSelected = false
            selectedCardsNumber -= 1
            }
        }
    
    func addCards() {
        UIView.animate(withDuration: 0.5, animations:  {
            for index in self.addCardsStackViews.indices {
                if self.addCardsStackViews[index].isHidden == true {
                    self.addCardsStackViews[index].isHidden = false
                    break
                }
            }
        })
    }
    
    func disableAddCardsButton() {
        var isHiddenStackViewsCount = 0
        for index in self.addCardsStackViews.indices {
            if self.addCardsStackViews[index].isHidden {
                isHiddenStackViewsCount += 1
            }
        }
        if isHiddenStackViewsCount == 0 {
            self.addCardsButton.isEnabled = false
        }
    }
    
    func selectedCards() -> [Card] {
        var selectedCards = [Card]()
        for index in game.inGameCards.indices {
            if game.inGameCards[index].isSelected == true {
                selectedCards.append(game.inGameCards[index])
        }
    }
    return selectedCards
    }
    
    func inticateIsSetResult(isSetResult: Bool) {
        let selectedCardsCount = selectedCards().count
        if isSetResult == true, selectedCardsCount == 3 {
            UIView.animate(withDuration: 1, animations:
                            {self.view.backgroundColor = UIColor.green})
            UIView.animate(withDuration: 1, animations:
                            {self.view.backgroundColor = UIColor.white})
        } else if isSetResult == false, selectedCardsCount == 3 {
            UIView.animate(withDuration: 1, animations:
                            {self.view.backgroundColor = UIColor.red})
            UIView.animate(withDuration: 1, animations:
                            {self.view.backgroundColor = UIColor.white})
            renderCards()
            deselectAllCards()
            }
    }
    
    func deselectAllCards() {
        for index in game.inGameCards.indices {
            game.inGameCards[index].isSelected = false
        }
    }
    
    func replaceMatchingSetCards(isSetResult: Bool) {
        if isSetResult {
            for index in game.inGameCards.indices {
                if game.inGameCards[index].isSelected {
                    if let pickedInGameCardIndex = game.cards.indices.randomElement() {
                        game.inGameCards[index] = game.cards.remove(at: pickedInGameCardIndex)
                    }
                }
            }
            updateViewFromModel()
            deselectAllCards()
            renderCards()
        }
    }
    
//TODO: Requirements
    
    //if the deck is empty then matched cards can’t be replaced, but they should be hidden in the UI.
    //if the card that was chosen was one of the 3 matching cards, then no card should be selected (since the selected card was either replaced or is no longer visible in the UI).
    
    //The Deal 3 More Cards button should be disabled if there are a) no more cards in the Set deck or b) no more room in the UI to fit 3 more cards (note that there is always room for 3 more cards if the 3 currently-selected cards are a match since you replace them).
    
    //Like you did for Concentration, you must have a New Game button and show the Score in the UI. It is up to you how you want to score your Set game. For example, you could give 3 points for a match and -5 for a mismatch and maybe even -1 for a deselection. Perhaps fewer points are scored depending on how many cards are on the table (i.e. how many times Deal 3 More Cards has been touched). Whatever you think best evaluates how well the player is playing.
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
