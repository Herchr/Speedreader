//
//  Practice.swift
//  Speedreader
//
//  Created by Herman Christiansen on 14/02/2022.
//

import SwiftUI

let text: [[String]] = ["Obsessed with the idea of creating ".components(separatedBy: " "), "creating life itself, Victor Frankenstein".components(separatedBy: " "),"Obsessed with the idea of".components(separatedBy: " "),"Obsessed with the idea of".components(separatedBy: " "),"Obsessed with the idea create of".components(separatedBy: " "),"Obsessed with the idea of".components(separatedBy: " "),"Obsessed with the idea nss of".components(separatedBy: " ")]
struct Practice: View {
    @State var currentLine: Int = 0
    @State var offset: Double = 0.0
    @State var lineWidths: [Int: Double] = [:]
    @State var opi: CGFloat = 1
    @State var t: [[String]] = text
    @State var slideanim: Bool = true
    func smellIgang(){
        withAnimation(.linear(duration: 1.2)){
            offset = lineWidths[currentLine]! - 60
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1){
            withAnimation(.linear(duration: 0.25)){
                opi = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                opi = 1
                if currentLine < 6{
                    currentLine += 1
                    offset = 0
                }else{
                    currentLine = 0
                    offset = 0
                    return
                }
                smellIgang()
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack{
                if slideanim{
                    VStack {
                        ForEach(Array(zip(text.indices, text)), id: \.0){ i, sentenceArray in
                            HStack(spacing: 0) {
                                ForEach(Array(zip(sentenceArray.indices, sentenceArray)), id: \.0){ j, w in
                                    Text("\(w) ")
                                }
                            }
                            .background(
                                GeometryReader{ geo -> Color in
                                    DispatchQueue.main.async {
                                        lineWidths[Int(i)] = geo.size.width
                                    }
                                    return Color.clear
                                }
                            )
                            .background(
                                VStack(alignment: .leading) {
                                    Spacer()
                                    HStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(width: 60, height: 5)
                                            .offset(x: offset)
                                            .opacity(currentLine == i ? 1 : 0)
                                            .opacity(opi)
                                        Spacer()
                                    }
                                }
                                    .offset(y: 3)
                            )
                            
                        }
                        
                    }
                    .transition(.slide)
                    .zIndex(1)
                }
                
            }
            Button("gønn på"){
                //smellIgang()
                withAnimation {
                    slideanim.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        slideanim.toggle()
                    }
                }
            }
//            Text("\(offset)")
////            if let lineWidths = lineWidths {
////                Text("\(lineWidths[currentLine])")
////            }
            
        }
    }
}

struct Practice_Previews: PreviewProvider {
    static var previews: some View {
        Practice()
    }
}
