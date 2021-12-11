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
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 25)
//                .frame(width: UIScreen.main.bounds.width*0.90, height: 150)
//                .offset(x: 5, y: 10)
//                .foregroundColor(Color(red: 225/255, green: 225/255, blue: 225/255))
            HStack {
                Spacer()
                Text(rsvpVM.rsvpText)
                    .font(.title)
                    .padding(.vertical, 60)
                    .foregroundColor(Color.theme.text)
                Spacer()
            } //: HStack
            .frame(width: UIScreen.main.bounds.width*0.9)
            .background(Color.white)
            .cornerRadius(20)
//            .overlay(
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(Color.gray, lineWidth: 2)
//                )
            .shadow(radius: 3)
        }
    }
}
//
//struct RSVPTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        RSVPView(vm: RSVPViewModel(text:["s"]))
//    }
//}
