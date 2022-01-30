//
//  EmojiMemoryGame.swift
//  Memorize
// ----------- VIEW MODEL ----------------
//          THE GATE KEEPER
//          THE INTERMEDIARY
//  Created by Victor Hugo Augusto Oliveira on 23/01/22.
//

import SwiftUI

//func makeCardContent(index: Int) -> String { ///// Essa função foi transformada em apenas {_ in "🤬"}
//    return "🤬"}


class EmojiMemoryGame: ObservableObject { //"ObservableObject can tell the world: "something changed" | EmojiMemoryGame acts like an ObservableObject"
    
    static let emojis = ["😐","😡","🥶","😱","🤡", "🤬","🤯","🤑","👺","🤖"] // estar fora da classe faz com que emojis seja uma variavel global e variáveis globais não são tão desejadas, por isso foi colocada dentro da classe com o parâmetro "static" para que passe a se chamar "EmojiMemoryGame.emojis" uma type variable
    
    static func createMemoryGame() -> MemoryGame<String> { // a função createMemoryGame retorna o parâmetro MemoryGame<String>
        MemoryGame<String>(numberOfPairsOfCards: 6) { pairIndex in   // o parâmetro "static" faz com a função "createMemoryGame" se torne uma função local de nome "EmojiMemoryGame.createMemoryGame" uma type function
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()// private make only the ViewModel see that model | private(set) tells swift taht other classes can only look/read the model, they cant change it
    // that function call can only be used during inicialization or  if you're already in a static func and you're accessing another static. Otherwise, you'll need to use the func fullname: "EmojiMemoryGame.func"
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
//        objectWillChange.send() // thats not necessaire anymore bc we've used @Pubished
        model.choose(card)
    }
}