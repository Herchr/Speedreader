//
//  SpeedPopOverView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 03/10/2021.
//

import SwiftUI

struct SpeedPopOverView: View {
    @ObservedObject var rsvpVM: RSVPViewModel
    var body: some View {
        ZStack(alignment:.bottom){
            // Background
            Color.black
                .opacity(rsvpVM.showSpeedPopOver ? 0.5 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring()){
                        rsvpVM.showSpeedPopOver.toggle()
                    }
                }
            // Slider
            ZStack {
                VStack {
                    Spacer()
                    VStack{
                        Spacer()
                        HStack {
                            Text("Words per minute:")
                                .foregroundColor(Color.theme.text)
                            Text("\(Int(rsvpVM.wpm))")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.theme.text)
                        }
                        Slider(value: $rsvpVM.wpm, in: 50...600, step: 50)
                            .padding()
                        Spacer()
                    } //:VSTACK
                    
                    
                } //:VSTACK
                .background(Color.white)
                .frame(width: UIScreen.main.bounds.width / 1.2, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.bottom, 140)
                .shadow(radius: 20)
            }
            
            
        } //:ZSTACK
        .frame(width: UIScreen.main.bounds.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
        
    }
    /*
    struct SquareWithTriangle: Shape {
        var radius: CGFloat = 20
        func path(in rect: CGRect) -> Path {
            var path = Path()

            let tl = CGPoint(x: rect.minX, y: rect.minY)
            let tlc = CGPoint(x: rect.minX + radius, y: rect.minY + radius)
            let tr = CGPoint(x: rect.maxX - radius, y: rect.minY)
            let trc = CGPoint(x: rect.maxX - radius, y: rect.minY + radius)
            let br = CGPoint(x: rect.maxX, y: rect.maxY-20 - radius)
            let brc = CGPoint(x: rect.maxX - radius, y: rect.maxY-20 - radius)

            let st = CGPoint(x: rect.midX + 20, y: rect.maxY-20)
            let mt = CGPoint(x: rect.midX, y: rect.maxY)
            let et = CGPoint(x: rect.midX - 20, y: rect.maxY - 20)

            let bl = CGPoint(x: rect.minX + radius, y: rect.maxY - 20)
            let blc = CGPoint(x: rect.minX + radius, y: rect.maxY - 20 - radius)
            let tlf = CGPoint(x: rect.minX, y: rect.minY + radius)


            path.move(to: tl)
            path.addLine(to: tr)
            path.addRelativeArc(center: trc, radius: radius, startAngle: .degrees(0), delta: .degrees(360))
            path.addLine(to: br)
            path.addRelativeArc(center: brc, radius: radius, startAngle: .degrees(0), delta: .degrees(90))
            path.addLine(to: st)
            path.addLine(to: mt)
            path.addLine(to: et)
            path.addLine(to: bl)
            path.addRelativeArc(center: blc, radius: radius, startAngle: .degrees(90), delta: .degrees(90))
            path.addLine(to: tlf)
            path.addRelativeArc(center: tlc, radius: radius, startAngle: .degrees(90), delta: .degrees(180))

            return path
        }
    }*/
}

struct SpeedPopOverView_Previews: PreviewProvider {
    static var previews: some View {
        RSVPView(vm: RSVPViewModel())
    }
}
