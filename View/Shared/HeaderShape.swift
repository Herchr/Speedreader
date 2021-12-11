//
//  HeaderShape.swift
//  Speedreader
//
//  Created by Herman Christiansen on 25/10/2021.
//

import SwiftUI

struct HeaderShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            path.move(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width , y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let control1 = CGPoint(x: rect.width * 0.25, y: rect.height * 0.65)
            let control2 = CGPoint(x: rect.width * 0.65, y: rect.height * 1.35)
            
            path.addCurve(to: CGPoint(x: rect.width, y: rect.height), control1: control1, control2: control2)
            
//            let curveBL = CGPoint(x: mid - 40, y: rect.height)
//            let curveBR = CGPoint(x: mid + 40, y: rect.height)
//            let curveT = CGPoint(x: mid, y: rect.height - 20)
//
//            let control1 = CGPoint(x: mid - 15, y: rect.height)
//            let control2 = CGPoint(x: mid - 15, y: rect.height - 20)
//            let control3 = CGPoint(x: mid + 15, y: rect.height - 20)
//            let control4 = CGPoint(x: mid + 15, y: rect.height)
//
//            path.move(to: curveBL)
//            path.addCurve(to: curveT, control1: control1, control2: control2)
//            path.addCurve(to: curveBR, control1: control3, control2: control4)
        }
    }
}

struct HeaderShape_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
