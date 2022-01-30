//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Victor Hugo Augusto Oliveira on 22/01/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame() // i only can do this because class is "free-init", that free-init is "do nothing", that doesn't initialize vars
    // that let game = EmojiMemoryGame() can be placed bc that let will point to EmojiMemoryGame, bc it's a class.
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
