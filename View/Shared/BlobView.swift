//
//  BlobView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 11/02/2022.
//

import SwiftUI

struct BlobView: View {
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Blob2()
                        .frame(width: 247, height: 222)
                        .foregroundStyle(
                            LinearGradient(colors: [Color.theme.redGradient1, Color.theme.accent], startPoint: .topTrailing, endPoint: .bottomLeading)
                        )
                    .offset(x: 0, y: 10)
                }
                Blob1()
                    .frame(width: 390, height: 300)
                    .foregroundStyle(
                        LinearGradient(colors: [Color.theme.accentGradient, Color.theme.accent], startPoint: .topTrailing, endPoint: .bottomLeading)
                    )
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct BlobView_Previews: PreviewProvider {
    static var previews: some View {
        BlobView()
    }
}

struct Blob1: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0.6992*height))
        path.addCurve(to: CGPoint(x: 0.76836*width, y: 0.69002*height), control1: CGPoint(x: 0.92251*width, y: 0.68528*height), control2: CGPoint(x: 0.84338*width, y: 0.66937*height))
        path.addCurve(to: CGPoint(x: 0.45913*width, y: 0.89184*height), control1: CGPoint(x: 0.65392*width, y: 0.7215*height), control2: CGPoint(x: 0.55608*width, y: 0.81571*height))
        path.addCurve(to: CGPoint(x: 0.15436*width, y: 0.98508*height), control1: CGPoint(x: 0.36218*width, y: 0.96797*height), control2: CGPoint(x: 0.26559*width, y: 1.02642*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.80782*height), control1: CGPoint(x: 0.0709*width, y: 0.95407*height), control2: CGPoint(x: 0.02531*width, y: 0.88877*height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.closeSubpath()
        return path
    }
}

struct Blob2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.9996*width, y: 0.28676*height))
        path.addLine(to: CGPoint(x: 0.9996*width, y: 0.7241*height))
        path.addCurve(to: CGPoint(x: 0.80016*width, y: 0.87523*height), control1: CGPoint(x: 0.94113*width, y: 0.78095*height), control2: CGPoint(x: 0.87045*width, y: 0.83221*height))
        path.addCurve(to: CGPoint(x: 0.37356*width, y: 0.99739*height), control1: CGPoint(x: 0.65976*width, y: 0.96081*height), control2: CGPoint(x: 0.51126*width, y: 0.99491*height))
        path.addCurve(to: CGPoint(x: 0.14559*width, y: 0.99117*height), control1: CGPoint(x: 0.29968*width, y: 0.99874*height), control2: CGPoint(x: 0.21543*width, y: 1.00189*height))
        path.addCurve(to: CGPoint(x: 0.00186*width, y: 0.88959*height), control1: CGPoint(x: 0.07198*width, y: 0.97964*height), control2: CGPoint(x: 0.01441*width, y: 0.95216*height))
        path.addCurve(to: CGPoint(x: 0.27194*width, y: 0.49063*height), control1: CGPoint(x: -0.02243*width, y: 0.76865*height), control2: CGPoint(x: 0.19923*width, y: 0.63194*height))
        path.addCurve(to: CGPoint(x: 0.41138*width, y: 0.09333*height), control1: CGPoint(x: 0.34283*width, y: 0.35275*height), control2: CGPoint(x: 0.27352*width, y: 0.20212*height))
        path.addCurve(to: CGPoint(x: 0.86255*width, y: 0.02455*height), control1: CGPoint(x: 0.55146*width, y: -0.01721*height), control2: CGPoint(x: 0.73802*width, y: -0.01477*height))
        path.addCurve(to: CGPoint(x: 0.99502*width, y: 0.27824*height), control1: CGPoint(x: 0.96826*width, y: 0.05802*height), control2: CGPoint(x: 0.94968*width, y: 0.19*height))
        path.addCurve(to: CGPoint(x: 0.9996*width, y: 0.28676*height), control1: CGPoint(x: 0.99648*width, y: 0.28126*height), control2: CGPoint(x: 0.99802*width, y: 0.28401*height))
        path.closeSubpath()
        return path
    }
}
