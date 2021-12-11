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
                Button(action: {
                    withAnimation(.spring()){
                        rsvpVM.showSpeedPopOver.toggle()
                    }
                    
                    print("\(rsvpVM.showSpeedPopOver)")
                }, label: {
                    LinearGradient(gradient: Gradient(colors: [Color.theme.accentGradient, Color.theme.accent]), startPoint: .top, endPoint: .bottom)
                        .mask(
                            Image(systemName:"speedometer")
                                .resizable()
                                .frame(width: 30, height: 30)
                        )
                        .frame(width: 30, height: 30)
                })
                    .padding(.trailing, 10)
            }
            .frame(width: UIScreen.main.bounds.width-20, alignment: .trailing)
            .foregroundColor(Color.theme.accent)
            
            HStack {
                // Go Backward
                Button(action: {
                }, label: {
                    LinearGradient(gradient: Gradient(colors: [Color.theme.accentGradient, Color.theme.accent]), startPoint: .top, endPoint: .bottom)
                        .mask(
                            Image(systemName: "gobackward.30")
                                .resizable()
                                .frame(width: 30, height: 30)
                        )
                        .frame(width: 30, height: 30)
                })
                // Play/Pause
                Button(action: {
                    withAnimation{
                        rsvpVM.toggleIsPlaying()
                    }
                }, label: {
                    LinearGradient(gradient: Gradient(colors: [Color.theme.accentGradient, Color.theme.accent]), startPoint: .top, endPoint: .trailing)
                        .mask(
                            Image(systemName: rsvpVM.isPlaying ? "pause.circle.fill" :"play.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                        )
                        .background(Color.white)
                        .clipShape(Circle())
                })
                .frame(width: 70, height: 70)
                .padding(.horizontal,40)
                
                // Go Forward
                Button(action: {
                    //rsvpVM.toggleIsPlaying()
                }, label: {
                    LinearGradient(gradient: Gradient(colors: [Color.theme.accentGradient, Color.theme.accent]), startPoint: .top, endPoint: .bottom)
                        .mask(
                            Image(systemName: "goforward.30")
                                .resizable()
                                .frame(width: 30, height: 30)
                        )
                        .frame(width: 30, height: 30)
                        
                })
            } //: HSTACK
            .foregroundColor(Color.theme.accent)
            
        } //: ZSTACK
        .foregroundColor(.black)
        .opacity(0.9)
    }
}

struct PlayStackView_Previews: PreviewProvider {
    static var previews: some View {
        RSVPView(vm: RSVPViewModel(text:["s"]))
    }
}
