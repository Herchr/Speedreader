//
//  PlayStackView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 03/10/2021.
//

import SwiftUI

struct PlayStackView: View {
    @ObservedObject var rsvpVM: RSVPViewModel
    
    var body: some View {
        ZStack {
            // SpeedButton
            HStack{
                Spacer()
                Button(action: {
                    withAnimation{
                        rsvpVM.showSpeedPopOver.toggle()
                    }
                }, label: {
                    Image(systemName:"speedometer")
                        .font(.system(size: 38).weight(.medium))
                        .foregroundColor(.black)
                        .padding(.trailing)
                })
                    
            }
            .foregroundColor(Color.theme.accent)
            
            HStack {
                // Go Backward
//                Button(action: rsvpVM.rewind, label: {
//                    LinearGradient(gradient: Gradient(colors: [Color.theme.accentGradient, Color.theme.accentGradient]), startPoint: .top, endPoint: .bottom)
//                        .mask(
//                            Image(systemName: "gobackward.30")
//                                .resizable()
//                                .frame(width: 30, height: 30)
//                        )
//                        .frame(width: 30, height: 30)
//                })
                // Play/Pause
                Button(action: {
                    DispatchQueue.main.async {
                        withAnimation(.spring()) {
                            rsvpVM.start()
                        }
                    }
                }, label: {
                    Image(systemName: "play.fill")
                        .font(.system(size: 40).weight(.bold))
                        .foregroundColor(.black)
                })
                .frame(width: 70, height: 70)
                .padding(.horizontal,40)
                
                // Go Forward
//                Button(action: rsvpVM.fastForward, label: {
//                    LinearGradient(gradient: Gradient(colors: [Color.theme.accentGradient, Color.theme.accentGradient]), startPoint: .top, endPoint: .bottom)
//                        .mask(
//                            Image(systemName: "goforward.30")
//                                .resizable()
//                                .frame(width: 30, height: 30)
//                        )
//                        .frame(width: 30, height: 30)
//
//                })
            } //: HSTACK
            .foregroundColor(Color.theme.accent)
            
        } //: ZSTACK
        .foregroundColor(.black)
        .opacity(0.9)
    }
}

struct PlayStackView_Previews: PreviewProvider {
    static var previews: some View {
        RSVPView(rsvpVM: RSVPViewModel())
    }
}
