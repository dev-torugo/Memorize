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
        
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            cardView(for: card)
        })
            .foregroundColor(.blue)
            .padding(.horizontal)
    }
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture{
                    game.choose(card)
                }
        }
    }
}

struct CardView: View { //dineroom chair -> replicate the cards | the cards will be equal 
    let card: EmojiMemoryGame.Card // that pass only a small part of the model
    
    //    init (_ card: EmojiMemoryGame.Card){ // that init allows the 17 line set.
    //        self.card = card // self.card -> that mean the 31 line card. green matches green and black/black
    
    var body: some View {
        GeometryReader { geometry in
            ZStack { // acumulou cartas no eixo Z
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                if card.isFaceUp{
                    shape.fill(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched{
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
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
