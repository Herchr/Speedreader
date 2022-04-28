//
//  ProgressBarView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 03/10/2021.
//

import SwiftUI

struct ProgressBarView: View {
    let percentage: CGFloat = 0.37
    
    let progressBarWidth: CGFloat = screen.width * 0.8
    var computedPercentage: CGFloat {
        progressBarWidth * percentage
    }
    
    @ObservedObject var rsvpVM: RSVPViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(Color.white)
                    .frame(width: progressBarWidth, height: 8, alignment: .leading)
                    .cornerRadius(30)
                Rectangle()
                    .overlay(LinearGradient(gradient: Gradient(colors: [Color.theme.accent, Color.theme.accent]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: progressBarWidth * rsvpVM.getPercentageProgress(), height: 8, alignment: .leading)
                    .cornerRadius(30)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.theme.accent, lineWidth: 2)
            )
            HStack{
                Spacer()
                Text("-\(rsvpVM.getTimeRemaining()) minutes")
                    .foregroundColor(Color.theme.text)
            }
            .padding(.horizontal, screen.width*0.1)
        }
    }
}


struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(rsvpVM: RSVPViewModel())
    }
}
