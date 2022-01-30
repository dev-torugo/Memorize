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
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? //optional

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
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else { // turns all the cards face-down
                for index in cards.indices{ // 0..<cards.count foi substituido por cards.indices
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
//        print("\(cards)")
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {  // createCardContent now is a argument for this function
        cards = Array<Card>() // faz com que cards seja uma array vazia
        // add the number of pairs x 2 cards to cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex) // a função createCardContent will be responsible to create the content of the cards and has the pairIndex as parameter
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // a don't care type
        var id: Int
    }
}
