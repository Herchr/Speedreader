//
//  GuidedView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 14/10/2021.


import SwiftUI

struct GuidedView: View {
    @ObservedObject var rsvpVM: RSVPViewModel
    @ObservedObject var kineticVM: KineticViewModel
    @StateObject var guidedVM: GuidedViewModel = GuidedViewModel()
    @EnvironmentObject var globalVM: GlobalViewModel
    
    
    func startGuided(sessionType: SessionType){
        guidedVM.sessionType = sessionType
        guidedVM.started = true
        withAnimation{
            globalVM.showTabBar = false
        }
        if sessionType == SessionType.RSVP{
            guidedVM.initialSpeed = rsvpVM.wpm
            rsvpVM.toggleIsPlaying()
            // TRIGGER FIRST CONTINUE POPUP
            delay(seconds: guidedVM.timeInterval){
                rsvpVM.toggleIsPlaying()
                withAnimation(.spring()){
                    guidedVM.showContinuePopUp = true
                }
            }
        }else{
            DispatchQueue.main.async {
                kineticVM.toggleIsPlaying()
            }
            
            // TRIGGER FIRST CONTINUE POPUP
            delay(seconds: guidedVM.timeInterval){
                if guidedVM.started{
                    kineticVM.toggleIsPlaying()
                    delay(seconds: guidedVM.popUpPause){
                        withAnimation(.spring()){
                            guidedVM.showContinuePopUp = true
                        }
                    }
                }
            }
        }
    }

    var body: some View {
        ZStack {
            if guidedVM.started{
                VStack{
                    //CLOSE BUTTON
                    HStack {
                        Button(action: {
                            guidedVM.endPrematurely()
                            if guidedVM.sessionType == SessionType.RSVP{
                                rsvpVM.stopTimer()
                            }else{
                                kineticVM.stopTimer()
                            }
                            delay(seconds: 0.2){
                                withAnimation(.spring()){
                                    globalVM.showTabBar = true
                                }
                            }
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black.opacity(0.75))
                        })
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    if guidedVM.sessionType == SessionType.RSVP{
                        RSVPTextView(rsvpVM: rsvpVM)
                    }else{
                        KineticTest(kineticVM: kineticVM)
                    }
                    Spacer()
                }
                .transition(.move(edge: .bottom))
            }else{
                if guidedVM.showCompleteScreen{
                    CompletedView()
                        .transition(.move(edge: .bottom))
                }else{
                    VStack {
                        Spacer()
                        VStack {
                            Text("Start a guided session with incrementing speed.")
                                .foregroundColor(Color.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .frame(width: UIScreen.main.bounds.width / 1.4)

                            HStack {
                                Button(action: {
                                    startGuided(sessionType: SessionType.KINETIC)
                                }, label: {
                                    Text("Kinetic")
                                        .font(Font.title3.bold())
                                        .kerning(2)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 25)
                                        .foregroundColor(Color.black)
                                        .background(Color.white)
                                        .clipShape(Capsule())
                            }) //:BUTTON

                                Button(action: {
                                    startGuided(sessionType: SessionType.RSVP)
                                }, label: {
                                    Text("RSVP")
                                        .font(Font.title3.bold())
                                        .kerning(2)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 35)
                                        .foregroundColor(Color.black)
                                        .background(Color.white)
                                        .clipShape(Capsule())
                            }) //:BUTTON
                            } //: HSTACK
                        } //: VSTACK
                        .padding()
                        .padding(.vertical, 30)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                    Spacer()
                    }
                }
            }
            
            //Popup
            if guidedVM.showContinuePopUp && guidedVM.started{
                ContinuePopUpView(guidedVM: guidedVM, rsvpVM: rsvpVM, kineticVM: kineticVM)
                    .transition(.move(edge: .bottom))
            }
        } //: ZSTACK
        .tabBarPadding(started: guidedVM.started)
        .background(
            Image("GuidedBG3")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
        
        
    }
}

struct GuidedView_Previews: PreviewProvider {
    static var previews: some View {
//        GuidedView(rsvpVM: RSVPViewModel(), kineticVM: KineticViewModel(), guidedVM: GuidedViewModel()).environmentObject(GlobalViewModel())
        ContentView()
    }
}
