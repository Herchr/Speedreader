//
//  CompletedView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 30/01/2022.
//

import SwiftUI

struct CompletedView: View {
    var body: some View {
        VStack{
            Spacer()
            LottieView(fileName: "Completed_animation", repeats: false)
                .frame(height: screen.height/2)
            Text("Session complete!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.text)
            Spacer()
            
        }
        .frame(height: screen.height + 40)
        .background(Color.theme.background, in: Rectangle())
        //.background(Image("GuidedBG3"))
        
        
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView()
    }
}
