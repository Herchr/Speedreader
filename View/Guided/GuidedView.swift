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
    @EnvironmentObject var globalVM: AppViewModel
    var firestoreManager: FirestoreManager = FirestoreManager()
    
    @State var inFocus: Bool = false
    
    func startGuided(sessionType: SessionType){
        guidedVM.sessionType = sessionType
        guidedVM.started = true
        withAnimation{
            globalVM.showTabBar = false
        }
        if sessionType == SessionType.RSVP{
            //guidedVM.initialSpeed = rsvpVM.wpm // ENDRE DENNE TIL FETCH FRA FIREBASE
            rsvpVM.start()
            // TRIGGER FIRST CONTINUE POPUP
            delay(seconds: guidedVM.timeInterval){
                rsvpVM.stop()
//                DispatchQueue.main.async {
//                    rsvpVM.stopTimer()
//                }
                withAnimation(.spring()){
                    guidedVM.showContinuePopUp = true
                }
            }
        }else{
            //guidedVM.initialSpeed = kineticVM.wpm
            delay(seconds: 1){
                kineticVM.toggleIsPlaying()
                
                // TRIGGER FIRST CONTINUE POPUP
                delay(seconds: guidedVM.timeInterval){
                    if guidedVM.started{
                        DispatchQueue.main.async {
                            kineticVM.toggleIsPlaying()
                        }
                        delay(seconds: guidedVM.popUpPause){
                            withAnimation(.spring()){
                                guidedVM.showContinuePopUp = true
                            }
                        }
                    }
                }
            }
        }
    }

    var body: some View {
        ZStack {
            //Text("\(kineticVM.wpm)")
            if guidedVM.started{
                VStack{
                    //CLOSE BUTTON
                    HStack {
                        Button(action: {
                            guidedVM.endPrematurely()
                            if guidedVM.sessionType == SessionType.RSVP{
                                rsvpVM.stop()
                            }else{
                                kineticVM.toggleIsPlaying()
                            }
                            delay(seconds: 0.2){
                                withAnimation(.spring()){
                                    globalVM.showTabBar = true
                                }
                            }
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color.theme.text)
                        })
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    if guidedVM.sessionType == SessionType.RSVP{
                        RSVPTextView(rsvpVM: rsvpVM)
                    }else{
                        KineticTextView(kineticVM: kineticVM)
                        
                    }
                    Spacer()
                }
                .transition(.move(edge: .bottom))
            }else{
                if guidedVM.showCompleteScreen{
                    CompletedView()
                        .ignoresSafeArea()
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
                                .frame(width: screen.width / 1.4)

                            HStack {
                                Button(action: {
                                    startGuided(sessionType: SessionType.KINETIC)
                                    firestoreManager.setTechnique(technique: "Kinetic")
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
                                    firestoreManager.setTechnique(technique: "RSVP")
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
                        .overlay(
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .stroke(Color.white, lineWidth: 1)
                                .blendMode(.overlay)
                        )
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
        //.tabBarPadding(started: guidedVM.started)
        .background(
            ZStack{
                if !guidedVM.started{
                    Image("GuidedBG2")
                        .resizable()
                        .frame(width: screen.width, height: screen.height)
                        .ignoresSafeArea()
                }
            }
            
        )
        .task{
            let wpm = await (firestoreManager.getWPMBefore() ?? 0)
            guidedVM.initialSpeed = wpm
            rsvpVM.wpm = wpm
            kineticVM.wpm = wpm
        }
    }
}

struct GuidedView_Previews: PreviewProvider {
    static var previews: some View {
        GuidedView(rsvpVM: RSVPViewModel(), kineticVM: KineticViewModel(), guidedVM: GuidedViewModel()).environmentObject(AppViewModel())
    }
}
