//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Victor Hugo Augusto Oliveira on 05/02/22.
// ----------- A GENERIC VIEW COMBINER ------------
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View {
    var items: [Item] // a dont care
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
