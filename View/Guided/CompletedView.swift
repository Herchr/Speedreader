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
                .frame(height: UIScreen.main.bounds.height/2)
            Text("Session complete!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.text)
            Spacer()
            
        }
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView()
    }
}
