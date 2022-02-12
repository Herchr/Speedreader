//
//  KineticTest.swift
//  Speedreader
//
//  Created by Herman Christiansen on 02/11/2021.
//

import SwiftUI

struct KineticTest: View {
    @ObservedObject var kineticVM: KineticViewModel
    var body: some View {
        VStack(alignment: .leading, spacing:0){
            ForEach(Array(zip(kineticVM.kineticText.indices, kineticVM.kineticText)), id: \.0){ index, textLine in
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(textLine)")
                        .multilineTextAlignment(.leading)
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.theme.primary)
                        .frame(width: kineticVM.lineWidth, height: 5, alignment: .leading)
                        .opacity(kineticVM.currLine == index ? 1 : 0)
                }
                .fixedSize(horizontal: true, vertical: false)
            }
            Button("animate"){
                DispatchQueue.main.async {
                    kineticVM.toggleIsPlaying()
                }
            }
        }
    }
}

struct KineticTest_Previews: PreviewProvider {
    static var previews: some View {
        KineticTest(kineticVM: KineticViewModel())
    }
}
