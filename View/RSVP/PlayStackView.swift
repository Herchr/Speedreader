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
                    DispatchQueue.main.async {
                        withAnimation{
                                rsvpVM.showSpeedPopOver.toggle()
                        }
                    }
                }, label: {
                    Image(systemName:"speedometer")
                        .font(.title)
                        .foregroundColor(Color.theme.text)
                        .padding(.trailing)
                })
                    
            }
            .foregroundColor(Color.theme.accent)
            
            HStack {
                 //Go Backward
                Button(action: rsvpVM.rewind, label: {
                    Image(systemName: "gobackward.30")
                        .font(.title)
                })
                    .frame(width: 44, height: 44)
                // Play/Pause
                Button(action: {
                    DispatchQueue.main.async {
                        withAnimation(.spring()) {
                            rsvpVM.start()
                        }
                    }
                }, label: {
                    Image(systemName: "play.fill")
                        .font(.largeTitle.bold())
                })
                .frame(width: 70, height: 70)
                .padding(.horizontal,10)
                
                // Go Forward
                Button(action: rsvpVM.fastForward, label: {
                    Image(systemName: "goforward.30")
                        .font(.title)
                })
                    .frame(width: 44, height: 44)
            } //: HSTACK
            
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
