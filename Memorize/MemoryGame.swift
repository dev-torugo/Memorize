//
//  MemomoryGame.swift
//  Memorize
// ------------ MVVM ---------------
//----------- THE LOGIC ------------
//  Created by Victor Hugo Augusto Oliveira on 23/01/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable { //<> to show the world the don't care" // where ... says we care about it a little bit
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? { // we gonna compute it from line 12 -> cards: Array<Card> by looking them all
        get {cards.indices.filter { cards [$0].isFaceUp }.oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) { // tells the worls that calling this function is going to change it
        //        print("hello") // every time someone tap a card "hello" will be printed on console
        //        if let chosenIndex = index(of: card) { -> old code
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content { // if it does i have a match!
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
                
            } else { // turns all the cards face-down
                
            }
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
        
    }
    //        print("\(cards)")
    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {  // createCardContent now is a argument for this function
        cards = [] // faz com que cards seja uma array vazia -> Array<Card>() pode ser substituido por [] pois o Swift ja sabe que cards é uma array (linha 12)
        // add the number of pairs x 2 cards to cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex) // a função createCardContent will be responsible to create the content of the cards and has the pairIndex as parameter
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false // Bool = false it isn't necessary
        var isMatched = false // Bool = false it isn't necessary
        let content: CardContent // a don't care type
        let id: Int
    }
}

extension Array{
    var oneAndOnly: Element? { // array dont care with optional
        if count == 1{
            return  first
        } else {
            return nil
        }
    }
}
