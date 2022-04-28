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
                VStack {
                    HStack {
                        Text("Words per minute")
                            .font(Font.subheadline)
                            .foregroundColor(Color.theme.text)
                        Spacer()
                    }
                    VStack {
                        Slider(value: $rsvpVM.wpm, in: 50...600, step: 50)
                        Text("\(Int(rsvpVM.wpm))")
                            .font(Font.title3.bold())
                            .foregroundColor(Color.theme.text)
                        Button {
                            withAnimation {
                                rsvpVM.showSpeedPopOver = false
                            }
                        } label: {
                            Text("Close")
                                .foregroundColor(.blue)
                                .padding(.top, 20)
                        }
                        
                    }
                }
            } //:VSTACK
            .padding(.top, 70)
            .padding([.horizontal, .bottom], 30)
            .background(.white, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .overlay(
                VStack {
                    ZStack {
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(height: 50)
                                .foregroundColor(Color.theme.accent)
                            Rectangle()
                                .frame(height: 25)
                                .foregroundColor(Color.theme.accent)
                        }
                        Text("Speed settings")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            )
            .padding(46)
            //.padding(.trailing,50)
            .padding(.top, 100)
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
        SpeedPopOverView(rsvpVM: RSVPViewModel())
    }
}
