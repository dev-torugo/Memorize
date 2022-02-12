//
//  Pie.swift
//  Memorize
//
// Background "PieThing" creation function
//
//  Created by Victor Hugo Augusto Oliveira on 12/02/22.
//
// clockwise = false -> draws the pie without a slice
//clockwise = true -> draws the slice without a pie

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle   // var because the animation step ahead
    var endAngle: Angle     // var because the animation step ahead
    var clockwise = false   // var because the animation step ahead
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint (
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(endAngle.radians))
        )
    
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise // need to be inverted to do the "Pie" the way we want, without ! Swift will draw the "slice" instead
        )
        p.addLine(to: center)
        return p
    }
}

