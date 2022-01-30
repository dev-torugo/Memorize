//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Victor Hugo Augusto Oliveira on 22/01/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame // that @ObservedObject means that when this says something change, rebuild my entire body
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture{
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.blue)
        .padding(.horizontal)
    }
}

struct CardView: View { //dineroom chair -> replicate the cards | the cards will be equal 
    let card: MemoryGame<String>.Card // that pass only a small part of the model
    
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





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
