//
//  ViewController.swift
//  Set
//
//  Created by Ольга on 18.06.2021.
//

import UIKit


class ViewController: UIViewController {
    
    private var game = Game()
    var startTimeOfPlay = Date()

    override func viewDidLoad() {
        startNewGame()
    }

    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            selectAndDeselecCards(by: cardNumber)
            startTimeOfPlay = Date()
            let selectedCardsInGame = selectedCards()
            isSet = game.isSet(selectedCards: selectedCardsInGame)
            inticateIsSetResult(isSetResult: isSet)
            if isSet {
                game.replaceMatchingSetCards(isSetResult: isSet)
                updateViewFromModel()
                deselectAllCards()
                addPenaltyToScoreAccordingToSpeedOfPlay(from: startTimeOfPlay)
            }
            if selectedCardsInGame.count == 3 {
                updateScoreLabel()
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
        game.addOnePointPenaltyToScoreWhenAddedMoreCards()
        updateScoreLabel()
    }
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        startNewGame()
    }
    @IBOutlet weak var scoreLabel: UILabel!
    
    var isSet = false
    func renderCards() {
        for index in cardButtons.indices {
            if isSet, game.cards == [], cardButtons[index].layer.borderColor == UIColor.green.cgColor {
                        cardButtons[index].isEnabled = false
            } else if cardButtons[index].isEnabled {
                cardButtons[index].layer.borderWidth = 2.0
                cardButtons[index].layer.borderColor = UIColor.gray.cgColor
                cardButtons[index].layer.cornerRadius = 8.0
            }
            if cardButtons[index].isEnabled == false {
                cardButtons[index].setTitle("", for: UIControl.State.normal)
                cardButtons[index].layer.borderWidth = 0
            }
        }
    }
    
    func hideAdditionalCards() {
        for index in addCardsStackViews.indices {
            addCardsStackViews[index].isHidden = true
        }
    }
    
//    let numberOfShapes = 3
    let shapes = ["▲","●","■"]
    let colors = ["red", "green", "purple"]
    let shades = ["solid", "striped", "open"]
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.inGameCards[index]
            if card.numberOfShapes == Card.Variant.v1, card.shape == Card.Variant.v1 {
                button.setTitle(shapes[0], for: UIControl.State.normal)
            } else if card.numberOfShapes == Card.Variant.v2, card.shape == Card.Variant.v1 {
                button.setTitle(shapes[0] + shapes[0], for: UIControl.State.normal)
            } else if card.numberOfShapes == Card.Variant.v3, card.shape == Card.Variant.v1 {
                button.setTitle(shapes[0] + shapes[0] + shapes[0], for: UIControl.State.normal)
            } else if card.numberOfShapes == Card.Variant.v1, card.shape == Card.Variant.v2 {
                button.setTitle(shapes[1], for: UIControl.State.normal)
            } else if card.numberOfShapes == Card.Variant.v2, card.shape == Card.Variant.v2 {
                button.setTitle(shapes[1] + shapes[1], for: UIControl.State.normal)
            } else if card.numberOfShapes == Card.Variant.v3, card.shape == Card.Variant.v2 {
                button.setTitle(shapes[1] + shapes[1] + shapes[1], for: UIControl.State.normal)
            } else if card.numberOfShapes == Card.Variant.v1, card.shape == Card.Variant.v3 {
                button.setTitle(shapes[2], for: UIControl.State.normal)
            } else if card.numberOfShapes == Card.Variant.v2, card.shape == Card.Variant.v3 {
                button.setTitle(shapes[2] + shapes[2], for: UIControl.State.normal)
            } else if card.numberOfShapes == Card.Variant.v3, card.shape == Card.Variant.v3 {
                button.setTitle(shapes[2] + shapes[2] + shapes[2], for: UIControl.State.normal)
            }
            var color = UIColor()
            if card.color == Card.Variant.v1, card.shade == Card.Variant.v1 {
                color = UIColor.red.solid
                button.setTitleColor(color, for: UIControl.State.normal)
            } else if card.color == Card.Variant.v1, card.shade == Card.Variant.v2 {
                color = UIColor.red.striped
                button.setTitleColor(color, for: UIControl.State.normal)
            } else if card.color == Card.Variant.v1, card.shade == Card.Variant.v3 {
                color = UIColor.red.open
                button.setTitleColor(color, for: UIControl.State.normal)
            } else if card.color == Card.Variant.v2, card.shade == Card.Variant.v1 {
                color = UIColor.green.solid
                button.setTitleColor(color, for: UIControl.State.normal)
            } else if card.color == Card.Variant.v2, card.shade == Card.Variant.v2 {
                color = UIColor.green.striped
                button.setTitleColor(color, for: UIControl.State.normal)
            } else if card.color == Card.Variant.v2, card.shade == Card.Variant.v3 {
                color = UIColor.green.open
                button.setTitleColor(color, for: UIControl.State.normal)
            } else if card.color == Card.Variant.v3, card.shade == Card.Variant.v1 {
                color = UIColor.purple.solid
                button.setTitleColor(color, for: UIControl.State.normal)
            } else if card.color == Card.Variant.v3, card.shade == Card.Variant.v2 {
                color = UIColor.purple.striped
                button.setTitleColor(color, for: UIControl.State.normal)
            } else if card.color == Card.Variant.v3, card.shade == Card.Variant.v3 {
                color = UIColor.purple.open
                button.setTitleColor(color, for: UIControl.State.normal)
            }
        }
        renderCards()
        updateScoreLabel()
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(game.score)"
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
    
    func enableAddCardsButton() {
        self.addCardsButton.isEnabled = true
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
    
    func addPenaltyToScoreAccordingToSpeedOfPlay(from time: Date) {
        let speedOfPlay = Date().timeIntervalSince(time)
        if speedOfPlay >= 60.0 {
            game.score -= 2
        } else if speedOfPlay < 60.0, speedOfPlay < 3.0 {
            game.score -= 1
        } else if speedOfPlay < 60.0, speedOfPlay >= 3.0 {
            game.score += 1
        }
        updateScoreLabel()
    }
    
    func detectionSetAvailableInTheVisibleCards() {
        addCardsStackView.isHidden = true
    }
    
    func startNewGame() {
        game = Game()
        renderCards()
        game.inGameCards = game.pickInGameCards(amount: cardButtons.count)
        updateViewFromModel()
        hideAdditionalCards()
        enableAddCardsButton()
        startTimeOfPlay = Date()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension UIColor {
    var solid: UIColor {
        return self.withAlphaComponent(1.0)
    }
    var striped: UIColor {
        return self.withAlphaComponent(0.5)
    }
    var open: UIColor {
        return self.withAlphaComponent(0.15)
    }
    
}
