//
//  SpeedPopOverView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 03/10/2021.
//

import SwiftUI

struct SpeedPopOverView: View {
    @ObservedObject var rsvpVM: RSVPViewModel
    
    @State var scaleValue: Double = 1
    @State var bgOpacity: Double = 0
    var body: some View {
        ZStack{
            Color.black
                .opacity(bgOpacity)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        rsvpVM.showSpeedPopOver = false
                    }
                }
            VStack{
                HStack {
                    Text("Words per minute:")
                        .font(Font.title3)
                        .foregroundColor(Color.theme.text)
                    Text("\(Int(rsvpVM.wpm))")
                        .font(Font.title3.bold())
                        .foregroundColor(Color.theme.text)
                }
                Slider(value: $rsvpVM.wpm, in: 50...600, step: 50)
            } //:VSTACK
            .padding(.vertical, 40)
            .padding(.horizontal)
            .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(40)
            //.padding(.trailing,50)
            .padding(.top, 100)
            .shadow(radius: 20)
            .scaleEffect(scaleValue)
            
        } //:ZSTACK
        .onAppear{
            withAnimation{
                scaleValue = 1.2
                bgOpacity = 0.3
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                withAnimation{
                    scaleValue = 1
                }
            }
        }
    }
}

struct SpeedPopOverView_Previews: PreviewProvider {
    static var previews: some View {
        RSVPView(rsvpVM: RSVPViewModel())
    }
}
