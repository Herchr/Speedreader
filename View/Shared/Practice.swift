//
//  Practice.swift
//  Speedreader
//
//  Created by Herman Christiansen on 12/10/2021.
//

import SwiftUI

struct Practice: View {
    @State var isAnimating: Bool = false
    var body: some View {
        VStack {
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.black)
                    .frame(height: 5)
                
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: isAnimating ? 300 : 0, height: 5)
                    .animation(isAnimating ? Animation.linear(duration: 3).repeatForever(autoreverses: false) : Animation.default)
            }
            .padding()
            
            Button(action: {
                isAnimating.toggle()
            }, label: {
                Text("Animate")
            })
        }
    }
}

struct Practice_Previews: PreviewProvider {
    static var previews: some View {
        Practice()
    }
}
