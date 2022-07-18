//
//  GameState.swift
//  WarCardGame

import Foundation



func fullDeck() -> [Card] {
    var result: [Card] = []
    //    for suit  in ["club", "diamond", "heart", "spade"] {
    for suit  in ["heart", "club"] {
        //        for value in ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"] {
        for value in ["2", "3", "4", "5"] {
            result.append(Card(suit: suit, value: value))
        }
    }
    return result
    //    return [Card(suit: "spade", value: "2"), Card(suit: "heart", value: "5"), Card(suit: "diamond", value: "6"), Card(suit: "club", value: "2")]
}

let VALUE_TO_INT: [String: Int] = ["2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 11, "Q": 12, "K": 13, "A": 14]

class Card {
    var suit: String
    var value: String
    
    init(suit: String, value: String) {
        self.suit = suit
        self.value = value
    }
    
    // returns, for example, "Playing_card_spade_2"
    func filename() -> String {
        return "Playing_card_\(suit)_\(value)"
    }
    
    func getIntValue() -> Int {
        return VALUE_TO_INT[value]!
    }
}

class GameState {
    var player1Deck: [Card] //最初手上有的牌
    var player2Deck: [Card]
    
    var player1Drawn: [Card] //放在桌面上的卡
    var player2Drawn: [Card]
    
    var player1Discard: [Card] //數字大的人拿走的卡
    var player2Discard:[Card]
    
    var gameEnded: Bool = false;
    
    init() {
        let gameDeck = fullDeck().shuffled()
        let mid = gameDeck.count / 2
        player1Deck = Array(gameDeck.prefix(upTo: mid)) //沒有Array包覆的情況下,player1Deck的類型是[Card]（Card的Array類型）,不等於gameDeck.prefix(upTo: mid)的類型ArraySlice,所以需要用Array包覆才會變成類型相等的Array
        player2Deck = Array(gameDeck.suffix(from: mid))
        
        player1Drawn = []
        player2Drawn = []
        
        player1Discard = []
        player2Discard = []
    }

    func isInBattle() -> Bool {
        !player1Drawn.isEmpty && !player2Drawn.isEmpty
    }
    
    func player1DrawCard() {
        if player1Deck.isEmpty && player1Discard.isEmpty {
            self.gameEnded = true
            return
        }
        
        if player1Deck.isEmpty {
            player1Deck = player1Discard.shuffled()
            player1Discard = []
        }
        
        let card = player1Deck.removeFirst()
        player1Drawn.append(card)
    }
    
    func player2DrawCard() {
        
        if player2Deck.isEmpty && player2Discard.isEmpty {
            self.gameEnded = true
            return
        }
        
        if player2Deck.isEmpty {
            player2Deck = player2Discard.shuffled()
            player2Discard = []
        }
        
        player2Drawn.append(player2Deck.removeFirst())

    }
    
    
    func player1VisibleCard() -> Card? {
        player1Drawn.last
    }
    
    func player2VisibleCard() -> Card? {
        player2Drawn.last
    }
    
    func decideBattle() {
        if player2VisibleCard()!.getIntValue() > player1VisibleCard()!.getIntValue(){
            player2Discard += player1Drawn
            player2Discard += player2Drawn
            player1Drawn = []
            player2Drawn = []
        } else if player1VisibleCard()!.getIntValue() > player2VisibleCard()!.getIntValue() {
            player1Discard += player2Drawn
            player1Discard += player1Drawn
            player2Drawn = []
            player1Drawn = []
        } else {
            for _ in 0...2 {
                player1DrawCard()
                player2DrawCard()
            }
            
        }
    }
    
    func player1CardCount() -> Int {
        return player1Deck.count + player1Discard.count
    }
    
    func player2CardCount() -> Int {
        return player2Deck.count  + player2Discard.count
    }
    func playerWin () -> Bool {
        return player2CardCount() == 0
    }
}


