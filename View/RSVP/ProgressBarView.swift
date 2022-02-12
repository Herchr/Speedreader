//
//  ProgressBarView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 03/10/2021.
//

import SwiftUI

struct ProgressBarView: View {
    let percentage: CGFloat
    
    let progressBarWidth: CGFloat = UIScreen.main.bounds.width * 0.8
    var computedPercentage: CGFloat {
        progressBarWidth * percentage
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(Color.white)
                    .frame(width: progressBarWidth, height: 8, alignment: .leading)
                    .cornerRadius(30)
                Rectangle()
                    .overlay(LinearGradient(gradient: Gradient(colors: [Color.theme.accent, Color.theme.accent]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: computedPercentage, height: 8, alignment: .leading)
                    .cornerRadius(30)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.theme.accent, lineWidth: 2)
            )
            HStack{
                Text("103m:35s")
                    .foregroundColor(Color.theme.text)
                Spacer()
                Text("-213m:22s")
                    .foregroundColor(Color.theme.text)
            }
            .padding(.horizontal, (UIScreen.main.bounds.width - progressBarWidth) / 2)
        }
    }
}


struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(percentage: 0.37)
    }
}
