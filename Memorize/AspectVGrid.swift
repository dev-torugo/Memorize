//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Victor Hugo Augusto Oliveira on 05/02/22.
// ----------- A GENERIC VIEW COMBINER ------------
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item] // a dont care
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) { // @ViewBuilder -> compiler knows that func is a ViewBuilder | @escaping -> compiler knows to holdon in that func
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    var body: some View {
        GeometryReader { geometry in
            VStack{ // making the GeometryReader flexible
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0) // making GeometryReader flexible
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat{
        var columCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columCount += 1
            rowCount = (itemCount + (columCount - 1)) / columCount
        } while columCount <  itemCount
        if columCount > itemCount {
            columCount = itemCount
        }
        return floor(size.width / CGFloat(columCount))
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
