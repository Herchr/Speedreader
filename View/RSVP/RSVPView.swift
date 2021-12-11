//
//  RSVPView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/09/2021.
//

import SwiftUI

struct RSVPView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var currentBookVM: CurrentBookViewModel
    @ObservedObject var rsvpVM: RSVPViewModel
    
    init(vm: RSVPViewModel){
        self.rsvpVM = vm
    }
    
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            rsvpVM.showSpeedPopOver ? AnyView(SpeedPopOverView(rsvpVM: rsvpVM).zIndex(4).edgesIgnoringSafeArea(.vertical)) : AnyView(Color.clear)
            Header(title: "Practice")
            
            VStack{
                Image(uiImage: UIImage(data:currentBookVM.currentBook!.img!)!)
                    .resizable()
                    .frame(width: 120, height: 160)
                    .cornerRadius(6)
                    .shadow(radius: 5, y:5)
                    .headerPadding()
                Spacer()
            }
            
            //Text
            RSVPTextView(rsvpVM: rsvpVM)
            
            VStack{
                Spacer()
                ProgressBarView(percentage: 0.37)
                PlayStackView(rsvpVM: rsvpVM)
                    .padding(.vertical, 20)
            } //: VStack
            .tabBarPadding()
        } //:ZSTACK
        .navigationBarHidden(true)
        .onDisappear{
            print("\(rsvpVM.currentIndex)")
        }
    }
}

//// MARK: - PREVIEW
//struct RSVPView_Previews: PreviewProvider {
//    static var previews: some View {
//        RSVPView(vm: RSVPViewModel(text:["s"]))
//    }
//}
