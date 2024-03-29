//
//  CardGame.swift
//  CardGame
//
//  Created by CHOMINJI on 28/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Dealerable: Playerable {
    func deal() -> Card?
    func hasEnounghCards(for requirement: Int) -> Bool
    func handlingDeck(by menu: DeckMenu) -> HandlingDeckResult
}

class Dealer<T: Deck>: Player, Dealerable {
    private var cardsInfo: CardsInfo
    private var deck: T
    
    init(deck: T) {
        self.deck = deck
        self.cardsInfo = CardsInfo()
    }
    
    func deal() -> Card? {
        if let card = deck.removeOne() as? Card {
            return card
        }
        return nil
    }
    
    func hasEnounghCards(for requirement: Int) -> Bool {
        return deck.count - requirement > 0
    }
    
    func handlingDeck(by menu: DeckMenu) -> HandlingDeckResult {
        switch menu {
        case .reset:
            deck.reset()
            return HandlingDeckResult.reset(deck.count)
        case .shuffle:
            deck.shuffle()
            return HandlingDeckResult.shuffle(deck.count)
        case .draw:
            let card = deck.removeOne() as? Card
            return HandlingDeckResult.draw(card, deck.count)
        }
    }
}
