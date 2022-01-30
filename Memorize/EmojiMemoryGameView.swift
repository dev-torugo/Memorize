//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Victor Hugo Augusto Oliveira on 22/01/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame // that @ObservedObject means that when this says something change, rebuild my entire body
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture{
                            game.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.blue)
        .padding(.horizontal)
    }
}

struct CardView: View { //dineroom chair -> replicate the cards | the cards will be equal 
    let card: EmojiMemoryGame.Card // that pass only a small part of the model
    
//    init (_ card: EmojiMemoryGame.Card){ // that init allows the 17 line set.
//        self.card = card // self.card -> that mean the 31 line card. green matches green and black/black
    
    var body: some View{
        ZStack { // acumulou cartas no eixo Z
            let shape = RoundedRectangle(cornerRadius: 30)
            
            if card.isFaceUp{
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched{
                shape.opacity(0)
                
            } else {
                shape.fill()
                
            }
            
        }
    }
}





struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
