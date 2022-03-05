//
//  RSVPTextView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 14/10/2021.
//

import SwiftUI

struct RSVPTextView: View {
   // @EnvironmentObject var currentBookVM: CurrentBookViewModel
    @ObservedObject var rsvpVM: RSVPViewModel
    
    var cornerRadius: CGFloat = 20
    
    var body: some View {

        // NEUMORPIC BACKGROUND
//        VStack {
//            ZStack {
//
//                HStack{
//                    Text(rsvpVM.rsvpText)
//                        .font(.title)
//                        .foregroundColor(Color.theme.text)
//                        .padding(40)
//                }
//                //.frame(width: 150, height: 150)
//
//
//                .background(
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                                       .fill(Color("kMainBg"))
//                                       //.frame(width: 135, height: 135)
//                                       .blur(radius: 15)
//                                       .opacity(0.7)
//                                       .shadow(color: Color("kLightShadow"), radius: 5, x: 10, y: 10)
//
//                )
//                .background(
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                                        .fill(Color("kMainBg"))
//                                        //.frame(width: 135, height: 135)
//                                        .blur(radius: 15)
//                                        .opacity(0.7)
//                                        .shadow(color: Color("kDarkShadow"), radius: 5, x: -10, y: -10)
//                )
//                .background(
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                                        .fill(Color("kMainBg"))
//                                        //.frame(width: 150, height: 150)
//
//                )
//            }
//            .mask(
//                RoundedRectangle(cornerRadius: cornerRadius)
//            )
//
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color("kMainBg"))
//        .edgesIgnoringSafeArea(.all)
        
        VStack{
            ZStack {
                HStack {
                    Text(rsvpVM.rsvpText)
                        .font(.title)
                        .foregroundColor(Color.black)
                } //: HStack
            }
//            Button("start"){
//                rsvpVM.start()
//            }
//            Button("stop"){
//                rsvpVM.stop()
//            }
        }
    }
}

struct RSVPTextView_Previews: PreviewProvider {
    static var previews: some View {
        RSVPTextView(rsvpVM: RSVPViewModel())
    }
}
