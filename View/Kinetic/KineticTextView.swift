//
//  KineticTextView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 14/10/2021.
//

import SwiftUI

struct KineticTextView: View {
    @ObservedObject var kineticVM: KineticViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let kineticText = kineticVM.kineticText{
                ForEach(Array(zip(kineticText.indices, kineticText)), id: \.0){ i, sentenceArray in
                    ZStack {
                        HStack(spacing: 0) {
                            ForEach(Array(zip(sentenceArray.indices, sentenceArray)), id: \.0){ j, w in
                                Text("\(w) ")
                                    .font(Font.system(.body, design: .serif))
                                    .foregroundColor(Color.theme.text)
                            }
                        }
                        .background(
                            GeometryReader{ geo -> Color in
                                DispatchQueue.main.async {
                                    kineticVM.lineWidths[Int(i)] = geo.size.width
                                }
                                return Color.clear
                            }
                        )
                        .background(
                            VStack(alignment: .leading) {
                                Spacer()
                                HStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(kineticVM.currentLine == i ? .black : .clear)
                                        .frame(width: 60, height: 5)
                                        //.scaleEffect(x: kineticVM.pointerScale, anchor: .bottomTrailing)
                                        .foregroundColor(Color.theme.text)
                                        .offset(x: kineticVM.pointerOffset)
                                        //.opacity(kineticVM.currentLine == i ? 1 : 0)
                                        .opacity(kineticVM.finishingLineOpacity)
                                    Spacer()
                                }
                            }
                            .offset(y: 3)
                            
                        )
                        
                    }
                }
            }
//            Button("gønn på"){
//                kineticVM.toggleIsPlaying()
//            }
            
        }
    }
}

struct KineticTextView_Previews: PreviewProvider {
    static var previews: some View {
        KineticTextView(kineticVM: KineticViewModel())
    }
}
